SitemapGenerator::Sitemap.default_host = ENV.fetch("APP_HOST", "https://baltimore.ai")
SitemapGenerator::Sitemap.public_path = "public/"

SitemapGenerator::Sitemap.create do
  add companies_path, priority: 0.9, changefreq: "weekly"
  add categories_path, priority: 0.7, changefreq: "monthly"
  add resources_path, priority: 0.7, changefreq: "monthly"
  add guides_path,    priority: 0.8, changefreq: "weekly"

  # Foundational pages (low priority; rarely change)
  add "/about",                priority: 0.5, changefreq: "yearly"
  add editorial_standards_path, priority: 0.5, changefreq: "yearly"
  add how_it_works_path,       priority: 0.5, changefreq: "yearly"
  add contact_path,            priority: 0.4, changefreq: "yearly"
  add "/privacy",              priority: 0.3, changefreq: "yearly"
  add "/terms",                priority: 0.3, changefreq: "yearly"

  Guide.published.find_each do |guide|
    add guide_path(guide), lastmod: guide.updated_at, priority: 0.9, changefreq: "monthly"
  end

  Company.published.find_each do |company|
    add company_path(company), lastmod: company.updated_at, priority: 0.8, changefreq: "monthly"
  end

  Resource.published.find_each do |resource|
    add resource_path(resource), lastmod: resource.updated_at, priority: 0.6, changefreq: "monthly"
  end

  Company::CATEGORIES.each do |slug|
    count = Company.published.where(primary_category: slug).count
    next if count < 3
    add category_path(slug), priority: 0.6, changefreq: "monthly"
  end
end
