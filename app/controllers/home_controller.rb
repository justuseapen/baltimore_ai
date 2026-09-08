class HomeController < ApplicationController
  def index
    @featured_companies = Company.published.includes(:tags).order(updated_at: :desc).limit(8)
    @category_counts = Company.published.group(:primary_category).count
    @resources = Resource.published.order(name: :asc).limit(6)
    @total_resources = Resource.published.count
    @total_companies = Company.published.count
    @guides = Guide.published.order(published_at: :desc, id: :desc).limit(3)
    @field_report = Guide.published.find_by(slug: "baltimore-ai-scene-september-2026")
  end
end
