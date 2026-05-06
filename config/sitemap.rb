SitemapGenerator::Sitemap.default_host = ENV.fetch("APP_HOST", "https://baltimore.ai")
SitemapGenerator::Sitemap.public_path = "public/"

SitemapGenerator::Sitemap.create do
  add companies_path, priority: 0.9, changefreq: "weekly"
  add categories_path, priority: 0.7, changefreq: "monthly"
  add resources_path, priority: 0.7, changefreq: "monthly"

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
