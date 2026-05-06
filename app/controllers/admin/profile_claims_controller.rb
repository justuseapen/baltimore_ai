class Admin::ProfileClaimsController < Admin::BaseController
  before_action :set_claim, only: [ :show, :approve, :reject ]

  def index
    @pending = ProfileClaim.pending_review.includes(:company).order(created_at: :asc)
    @recent  = ProfileClaim.where.not(review_status: "pending_review").includes(:company).order(updated_at: :desc).limit(20)
  end

  def show
  end

  def approve
    user = User.find_or_initialize_by(email: @claim.email)
    user.role ||= "owner"
    Company.transaction do
      user.save!
      @claim.company.update!(
        user: user,
        claimed: true,
        status: @claim.company.status == "draft" ? "published" : @claim.company.status,
        last_verified_at: Time.current
      )
      @claim.update!(
        review_status: "approved",
        reviewed_by: current_user.email,
        reviewed_at: Time.current,
        completed_at: Time.current,
        current_step: "done"
      )
    end
    ProfileClaimMailer.welcome(user, @claim.company).deliver_later
    redirect_to admin_profile_claims_path, notice: "Approved #{@claim.company.name}."
  end

  def reject
    @claim.update!(
      review_status: "rejected",
      reviewed_by: current_user.email,
      reviewed_at: Time.current
    )
    redirect_to admin_profile_claims_path, notice: "Rejected claim for #{@claim.company.name}."
  end

  private

  def set_claim
    @claim = ProfileClaim.includes(:company).find(params[:id])
  end
end
