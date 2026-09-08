origin = public_site_url

xml.instruct! :xml, version: "1.0", encoding: "UTF-8"
xml.urlset xmlns: "http://www.sitemaps.org/schemas/sitemap/0.9" do
  @static_paths.each do |path|
    xml.url { xml.loc "#{origin}#{path}" }
  end

  @companies.find_each do |company|
    xml.url do
      xml.loc "#{origin}#{company_path(company)}"
      xml.lastmod company.updated_at.iso8601
    end
  end

  @resources.find_each do |resource|
    xml.url do
      xml.loc "#{origin}#{resource_path(resource)}"
      xml.lastmod resource.updated_at.iso8601
    end
  end

  @guides.find_each do |guide|
    xml.url do
      xml.loc "#{origin}#{guide_path(guide)}"
      xml.lastmod guide.updated_at.iso8601
    end
  end

  @categories.each do |category|
    xml.url { xml.loc "#{origin}#{category_path(category)}" }
  end
end
