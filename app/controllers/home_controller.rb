class HomeController < ApplicationController
  def index
    @featured_companies = Company.published.includes(:tags).order(updated_at: :desc).limit(8)
    @category_counts = Company.published.group(:primary_category).count
    @resources = Resource.published.order(name: :asc).limit(6)
    @total_companies = Company.published.count
  end
end
