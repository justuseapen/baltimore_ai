class CompaniesController < ApplicationController
  def index
    @companies = Company.published.includes(:tags).order(name: :asc)
    @category_counts = Company.published.group(:primary_category).count
  end

  def show
    @company = Company.published.includes(:tags).find_by!(slug: params[:slug])
    @similar_companies = Company.published
                                .where(primary_category: @company.primary_category)
                                .where.not(id: @company.id)
                                .order(updated_at: :desc)
                                .limit(5)
  end
end
