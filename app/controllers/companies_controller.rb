class CompaniesController < ApplicationController
  before_action :set_company, only: [ :show, :edit, :update ]
  before_action :require_owner!, only: [ :edit, :update ]

  def index
    @companies = Company.published.includes(:tags).order(name: :asc)
    @category_counts = Company.published.group(:primary_category).count
  end

  def show
    @similar_companies = Company.published
                                .where(primary_category: @company.primary_category)
                                .where.not(id: @company.id)
                                .order(updated_at: :desc)
                                .limit(5)
  end

  def edit
  end

  def update
    if @company.update(company_params)
      @company.tag_ids = Array(params[:tag_ids]).reject(&:blank?).map(&:to_i) if params.key?(:tag_ids)
      @company.update!(last_verified_at: Time.current)
      redirect_to company_path(@company), notice: "Listing updated."
    else
      flash.now[:alert] = @company.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_company
    scope = (action_name == "show") ? Company.published : Company.all
    @company = scope.includes(:tags).find_by!(slug: params[:slug])
  end

  def require_owner!
    unless signed_in? && current_user.company&.id == @company.id
      redirect_to (signed_in? ? root_path : sign_in_request_path), alert: "Not authorized."
    end
  end

  def company_params
    params.expect(company: [
      :tagline, :description, :website,
      :linkedin_url, :github_url, :crunchbase_url, :twitter_url,
      :city, :state, :founded_year, :employee_count_bucket
    ])
  end
end
