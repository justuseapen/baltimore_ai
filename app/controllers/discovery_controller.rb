class DiscoveryController < ApplicationController
  def sitemap
    @static_paths = [
      root_path, companies_path, categories_path, resources_path, guides_path,
      about_path, editorial_standards_path, how_it_works_path, contact_path,
      privacy_path, terms_path
    ]
    @companies = Company.published.select(:id, :slug, :updated_at)
    @resources = Resource.published.select(:id, :slug, :updated_at)
    @guides = Guide.published.select(:id, :slug, :updated_at)
    counts = Company.published.group(:primary_category).count
    @categories = Company::CATEGORIES.select do |category|
      counts.fetch(category, 0) >= CategoriesController::THIN_THRESHOLD
    end

    # Build from the current published records on every request. A generated
    # public file can silently retain hidden listings or miss new publications.
    response.headers["Cache-Control"] = "no-cache"
    render formats: :xml, layout: false
  end

  def legacy_sitemap
    redirect_to "#{public_site_url}/sitemap.xml", status: :moved_permanently, allow_other_host: true
  end
end
