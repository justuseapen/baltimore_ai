class ProfileClaimsController < ApplicationController
  WIZARD_STEPS = %w[basics story links tags].freeze

  before_action :set_company
  before_action :reject_already_claimed!
  before_action :set_claim_for_wizard, only: [ :show_step, :update_step ]

  def start
  end

  def send_code
    email = params[:email].to_s.strip.downcase
    name  = params[:claimant_name].to_s.strip

    if email.blank? || !email.match?(URI::MailTo::EMAIL_REGEXP)
      redirect_to claim_path(@company), alert: "Enter a valid email address."
      return
    end

    @claim = ProfileClaim.find_or_initialize_by(company: @company, email: email)
    @claim.claimant_name = name if name.present?
    @claim.review_status ||= "pending"
    @claim.current_step  ||= "verify"

    unless @claim.persisted? || @claim.save
      redirect_to claim_path(@company), alert: @claim.errors.full_messages.to_sentence
      return
    end

    unless @claim.can_send_code?
      redirect_to claim_path(@company),
        alert: "Slow down — try again in #{@claim.cooldown_seconds_remaining}s." and return
    end

    code = @claim.generate_verification_code!
    ProfileClaimMailer.verification_code(@claim, code).deliver_later
    session[:profile_claim_id] = @claim.id

    redirect_to action: :code_form
  end

  def code_form
    @claim = current_claim
    redirect_to claim_path(@company) and return unless @claim
  end

  def confirm_code
    @claim = current_claim
    redirect_to claim_path(@company) and return unless @claim

    code = params[:code].to_s.strip
    unless @claim.verify_code(code)
      redirect_to action: :code_form, alert: "Invalid or expired code." and return
    end

    @claim.approve_or_queue_review!

    if @claim.review_status == "pending_review"
      ProfileClaimMailer.admin_new_claim(@claim).deliver_later
      redirect_to claim_path(@company), notice: "Verified — your claim is in admin review. We'll email you when it's approved." and return
    end

    @claim.update!(current_step: WIZARD_STEPS.first)
    redirect_to claim_wizard_step_path(@company, WIZARD_STEPS.first)
  end

  def show_step
    @step = params[:step]
    redirect_to claim_path(@company) and return unless WIZARD_STEPS.include?(@step)
  end

  def update_step
    @step = params[:step]
    redirect_to claim_path(@company) and return unless WIZARD_STEPS.include?(@step)

    case @step
    when "basics" then update_basics
    when "story"  then update_story
    when "links"  then update_links
    when "tags"   then update_tags_and_finalize
    end
  end

  private

  def set_company
    @company = Company.find_by!(slug: params[:slug])
  end

  def reject_already_claimed!
    return unless @company.claimed?
    redirect_to company_path(@company), alert: "This listing has already been claimed."
  end

  def current_claim
    return @current_claim if defined?(@current_claim)
    cid = session[:profile_claim_id]
    @current_claim = cid ? ProfileClaim.find_by(id: cid, company_id: @company.id) : nil
  end

  def set_claim_for_wizard
    @claim = current_claim
    if @claim.nil? || !@claim.approved?
      redirect_to claim_path(@company), alert: "Please verify your email first."
    end
  end

  def update_basics
    @company.assign_attributes(params.expect(company: [ :tagline, :website, :city, :state, :founded_year ]))
    save_step_or_render("basics", next_step: "story")
  end

  def update_story
    @company.assign_attributes(params.expect(company: [ :description, :employee_count_bucket ]))
    save_step_or_render("story", next_step: "links")
  end

  def update_links
    @company.assign_attributes(params.expect(company: [ :linkedin_url, :github_url, :crunchbase_url, :twitter_url ]))
    save_step_or_render("links", next_step: "tags")
  end

  def update_tags_and_finalize
    tag_ids = Array(params[:tag_ids]).reject(&:blank?).map(&:to_i)
    Company.transaction do
      @company.tag_ids = tag_ids
      @company.save!
      finalize_claim!
    end
    redirect_to company_path(@company), notice: "Welcome aboard. #{@company.name} is now live."
  rescue ActiveRecord::RecordInvalid => e
    flash.now[:alert] = e.record.errors.full_messages.to_sentence
    @step = "tags"
    render :show_step, status: :unprocessable_entity
  end

  def save_step_or_render(step, next_step:)
    if @company.save
      @claim.update!(current_step: next_step)
      redirect_to claim_wizard_step_path(@company, next_step)
    else
      flash.now[:alert] = @company.errors.full_messages.to_sentence
      @step = step
      render :show_step, status: :unprocessable_entity
    end
  end

  def finalize_claim!
    user = User.find_or_initialize_by(email: @claim.email)
    user.role ||= "owner"
    user.save!
    @company.update!(
      user: user,
      claimed: true,
      status: @company.status == "draft" ? "published" : @company.status,
      last_verified_at: Time.current
    )
    @claim.update!(completed_at: Time.current, current_step: "done")
    sign_in_as(user)
    ProfileClaimMailer.welcome(user, @company).deliver_later
  end
end
