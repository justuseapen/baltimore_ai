require "test_helper"
require "nokogiri"

class DiscoveryTest < ActionDispatch::IntegrationTest
  setup do
    @original_app_host = ENV["APP_HOST"]
    ENV["APP_HOST"] = "https://baltimore.ai"
  end

  teardown do
    ENV["APP_HOST"] = @original_app_host
  end

  test "sitemap lists public records and excludes unpublished records and thin categories" do
    companies = 3.times.map do |index|
      create_company("Published company #{index}")
    end
    2.times { |index| create_company("Thin category #{index}", primary_category: "consulting") }
    hidden_company = create_company("Hidden company", status: "hidden", primary_category: "consulting")
    draft_company = create_company("Draft company", status: "draft", primary_category: "consulting")
    published_resource = create_resource("Public lab")
    hidden_resource = create_resource("Hidden lab", status: "hidden")
    draft_resource = create_resource("Draft lab", status: "draft")
    published_guide = create_guide("Public guide")
    hidden_guide = create_guide("Hidden guide", status: "hidden")
    draft_guide = create_guide("Draft guide", status: "draft")
    undated_guide = create_guide("Undated guide", published_at: nil)

    get "/sitemap.xml"

    assert_response :success
    assert_equal "application/xml", response.media_type
    urls = sitemap_urls
    assert_includes urls, "https://baltimore.ai/"
    companies.each { |company| assert_includes urls, "https://baltimore.ai#{company_path(company)}" }
    assert_includes urls, "https://baltimore.ai#{resource_path(published_resource)}"
    assert_includes urls, "https://baltimore.ai#{guide_path(published_guide)}"
    assert_includes urls, "https://baltimore.ai/categories/applied_ai"
    assert_not_includes urls, "https://baltimore.ai/categories/consulting"
    [ hidden_company, draft_company ].each do |company|
      assert_not_includes urls, "https://baltimore.ai#{company_path(company)}"
    end
    [ hidden_resource, draft_resource ].each do |resource|
      assert_not_includes urls, "https://baltimore.ai#{resource_path(resource)}"
    end
    [ hidden_guide, draft_guide, undated_guide ].each do |guide|
      assert_not_includes urls, "https://baltimore.ai#{guide_path(guide)}"
    end
    assert_equal urls.uniq, urls
  end

  test "sitemap reflects publication changes without a generation step" do
    company = create_company("Changing publication")
    company_url = "https://baltimore.ai#{company_path(company)}"

    get "/sitemap.xml"
    assert_includes sitemap_urls, company_url
    assert_equal "no-cache", response.headers["Cache-Control"]

    company.update!(status: "hidden")
    resource = create_resource("Newly published resource")
    get "/sitemap.xml"
    assert_not_includes sitemap_urls, company_url
    assert_includes sitemap_urls, "https://baltimore.ai#{resource_path(resource)}"
  end

  test "sitemap escapes XML and reports actual record modification time" do
    company = create_company("Research and analytics")
    # Exercise XML escaping even for legacy rows that predate slug validation.
    company.update_columns(slug: "research&analytics", updated_at: Time.utc(2026, 9, 1, 12))

    get "/sitemap.xml"

    assert_response :success
    assert_includes response.body, "research&amp;analytics"
    assert_includes sitemap_urls, "https://baltimore.ai#{company_path(company)}"
    assert_includes response.body, "<lastmod>2026-09-01T12:00:00Z</lastmod>"
  end

  test "discovery URLs use the configured origin instead of an incoming host" do
    host! "untrusted.example"
    ENV["APP_HOST"] = "https://directory.example/ignored?campaign=one#fragment"

    get "/sitemap.xml"

    assert_response :success
    assert sitemap_urls.all? { |url| url.start_with?("https://directory.example/") }
    assert_not_includes response.body, "untrusted.example"
    assert_not_includes response.body, "campaign"
  end

  test "legacy compressed sitemap redirects permanently to the live endpoint" do
    get "/sitemap.xml.gz"

    assert_response :moved_permanently
    assert_redirected_to "https://baltimore.ai/sitemap.xml"
  end

  test "robots txt is served by the application and advertises the live sitemap" do
    host! "untrusted.example"

    get "/robots.txt"

    assert_response :success
    assert_equal "text/plain", response.media_type
    assert_includes response.body, "User-agent: *\nAllow: /"
    %w[/admin /claim /sign-in /sign-out /companies/*/edit /up].each do |path|
      assert_includes response.body, "Disallow: #{path}\n"
    end
    assert_includes response.body, "Sitemap: https://baltimore.ai/sitemap.xml"
    assert_not_includes response.body, "untrusted.example"
    assert_not_includes response.body, "sitemap.xml.gz"
  end

  test "canonical and social URLs share a stable origin and omit tracking queries" do
    host! "untrusted.example"

    get "/about?utm_source=search&ref=ai"

    assert_response :success
    assert_select "link[rel=canonical][href='https://baltimore.ai/about']", count: 1
    assert_select "meta[property='og:url'][content='https://baltimore.ai/about']", count: 1
    assert_select "meta[property='og:image']" do |elements|
      assert elements.first["content"].start_with?("https://baltimore.ai/assets/")
    end
  end

  test "local canonical URLs retain the request origin when APP_HOST is unset" do
    ENV.delete("APP_HOST")
    host! "preview.example"

    get "/about?utm_source=local"

    assert_response :success
    assert_select "link[rel=canonical][href='http://preview.example/about']", count: 1
  end

  test "production canonical URLs default to the public origin without APP_HOST" do
    ENV.delete("APP_HOST")
    host! "untrusted.example"

    original_environment = Rails.env
    begin
      Rails.env = "production"
      get "/about?utm_source=search"
    ensure
      Rails.env = original_environment
    end

    assert_response :success
    assert_select "link[rel=canonical][href='https://baltimore.ai/about']", count: 1
  end

  test "structured data parses safely and uses the canonical publisher and website IDs" do
    company = create_company("AI </script><script>unexpected()</script> & Research")
    host! "untrusted.example"

    get company_path(company)

    assert_response :success
    scripts = Nokogiri::HTML(response.body).css("script[type='application/ld+json']")
    data = scripts.map { |script| JSON.parse(script.text) }
    site = data.find { |entry| entry.key?("@graph") }.fetch("@graph")
    publisher = site.find { |entry| entry["@type"] == "Organization" }
    website = site.find { |entry| entry["@type"] == "WebSite" }
    assert_equal "https://baltimore.ai/#organization", publisher.fetch("@id")
    assert_equal "https://baltimore.ai/#website", website.fetch("@id")
    assert_equal publisher.fetch("@id"), website.fetch("publisher").fetch("@id")
    crumbs = data.find { |entry| entry["@type"] == "BreadcrumbList" }.fetch("itemListElement")
    assert_equal company.name, crumbs.last.fetch("name")
    assert_equal "https://baltimore.ai/", crumbs.first.fetch("item")
    scripts.each { |script| assert_not_includes script.text, "</script>" }

    get companies_path
    index_data = css_select("script[type='application/ld+json']").map { |script| JSON.parse(script.text) }
    items = index_data.find { |entry| entry["@type"] == "ItemList" }.fetch("itemListElement")
    assert_equal "https://baltimore.ai#{company_path(company)}", items.first.fetch("url")
    assert_equal company.name, items.first.fetch("name")
  end

  private

  def sitemap_urls
    document = Nokogiri::XML(response.body) { |config| config.strict.nonet }
    document.xpath("//s:url/s:loc", "s" => "http://www.sitemaps.org/schemas/sitemap/0.9").map(&:text)
  end

  def create_company(name, **attributes)
    Company.create!({ name: name, primary_category: "applied_ai", status: "published" }.merge(attributes))
  end

  def create_resource(name, **attributes)
    Resource.create!({ name: name, resource_type: "lab", status: "published" }.merge(attributes))
  end

  def create_guide(title, **attributes)
    Guide.create!({ title: title, body: "A researched guide.", status: "published", published_at: Time.utc(2026, 9, 1) }.merge(attributes))
  end
end
