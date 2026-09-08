require "test_helper"

class EditorialContentTest < ActionDispatch::IntegrationTest
  setup do
    EditorialRefresh.from_files.call
  end

  test "researched pages expose sources, dates, valid metadata and a single heading" do
    titles = []
    records = Company.published.to_a + Resource.published.to_a + Guide.published.to_a
    records.each do |record|
      get polymorphic_path(record)
      assert_response :success
      assert_select "h1", count: 1
      assert_select "section[aria-label='Research sources'] time[datetime='2026-09-08']", count: 1
      record.source_references.each do |source|
        assert_select "a[href=?]", source.fetch("url"), minimum: 1
      end
      title = css_select("title").first.text
      assert_operator title.length, :<=, 60, "Title too long: #{title}"
      titles << title
      assert_operator css_select("meta[name='description']").first["content"].length, :<=, 160
      css_select("script[type='application/ld+json']").each { |script| assert JSON.parse(script.text) }
    end
    assert_equal titles.uniq, titles, "Published content has duplicate page titles"
  end

  test "guide internal links resolve and citations render as links" do
    paths = []
    Guide.published.each do |guide|
      get guide_path(guide)
      assert_select ".prose-editorial a[href^='https://']", minimum: 1
      paths.concat(css_select(".prose-editorial a[href^='/']").map { |link| link["href"] })
      article = css_select("script[type='application/ld+json']").map { |script| JSON.parse(script.text) }.find { |data| data["@type"] == "Article" }
      assert_equal guide.source_references.map { |source| source.fetch("url") }, article.fetch("citation")
      assert_equal article.fetch("url"), article.fetch("mainEntityOfPage").fetch("@id")
    end
    paths.uniq.each do |path|
      get path
      assert_response :success, "Broken internal guide link: #{path}"
    end
  end

  test "homepage counts all published resources and links the field report" do
    get root_path
    assert_select "h1", count: 1
    assert_includes response.body, "#{Resource.published.count} research, learning, and community resources"
    assert_select "a[href=?]", guide_path("baltimore-ai-scene-september-2026"), minimum: 1
    assert_select "a[href=?]", guide_path("baltimore-ai-events-fall-2026"), minimum: 1
  end

  test "event tables retain their structure and unsafe markup remains stripped" do
    guide = Guide.find_by!(slug: "baltimore-ai-events-fall-2026")
    guide.update!(body: guide.body + "\n\n<script>alert('unsafe')</script>\n<a href='javascript:alert(1)' onclick='alert(1)'>Unsafe</a>")
    get guide_path(guide)
    assert_select ".prose-editorial table", count: 1
    assert_select ".prose-editorial thead th", count: 4
    assert_select ".prose-editorial tbody tr", count: 4
    assert_select ".prose-editorial a#dated-events-and-deadlines[href='#dated-events-and-deadlines'][aria-hidden='true']", count: 1
    assert_select ".prose-editorial script, .prose-editorial [onclick], .prose-editorial [href^='javascript:']", count: 0
  end

  test "future guides are not public or included in discovery" do
    future = Guide.create!(slug: "future-research", title: "Future report", body: "Not yet public", status: "published", published_at: 1.day.from_now)
    assert_not Guide.published.exists?(future.id)
    get guide_path(future)
    assert_response :not_found
    get sitemap_path
    assert_not_includes response.body, future.slug
  end
end
