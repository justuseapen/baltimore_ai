class CategoriesController < ApplicationController
  THIN_THRESHOLD = 3

  def index
    @categories = Company::CATEGORIES
    @counts = Company.published.group(:primary_category).count
  end

  def show
    @category = params[:slug]
    raise ActionController::RoutingError, "Unknown category" unless Company::CATEGORIES.include?(@category)

    @companies = Company.published.where(primary_category: @category).includes(:tags).order(name: :asc)
    @thin = @companies.count < THIN_THRESHOLD
  end
end
