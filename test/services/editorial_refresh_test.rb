require "test_helper"

class EditorialRefreshTest < ActiveSupport::TestCase
  setup do
    @entry = {
      "slug" => "researched-company", "name" => "Researched company",
      "primary_category" => "applied_ai", "website" => "https://example.org",
      "description" => "Sourced description", "status" => "published",
      "reviewed_on" => "2026-09-08",
      "source_references" => [ { "title" => "Company website", "url" => "https://example.org", "publisher" => "Company" } ],
      "tags" => [ "machine-learning" ]
    }
    @catalog = { "companies" => [ @entry ], "resources" => [], "guides" => [], "retired_companies" => [] }
  end

  test "imports sources and replaces obsolete tags without changing timestamps on rerun" do
    company = Company.create!(slug: @entry["slug"], name: "Old name", primary_category: "other")
    company.tags << Tag.create!(slug: "obsolete-tag", name: "Obsolete tag")
    EditorialRefresh.new(@catalog).call
    company.reload
    assert_equal "Researched company", company.name
    assert_equal Date.new(2026, 9, 8), company.reviewed_on
    assert_equal [ "machine-learning" ], company.tags.pluck(:slug)
    assert_equal "https://example.org", company.source_references.first.fetch("url")
    updated_at = company.updated_at
    counts = [ Company.count, Tag.count, CompanyTag.count ]
    travel 1.day do
      EditorialRefresh.new(@catalog).call
    end
    assert_equal updated_at, company.reload.updated_at
    assert_equal counts, [ Company.count, Tag.count, CompanyTag.count ]
  end

  test "preserves claimed and owner-linked listings including retirement" do
    owner = User.create!(email: "research-owner@example.org")
    company = Company.create!(slug: @entry["slug"], name: "Owner copy", primary_category: "other", user: owner, claimed: true, status: "published")
    @catalog["retired_companies"] = [ { "slug" => company.slug, "reason" => "Missing evidence" } ]
    result = EditorialRefresh.new(@catalog).call
    assert_equal "Owner copy", company.reload.name
    assert_equal "published", company.status
    assert_nil company.reviewed_on
    assert_includes result.fetch(:skipped), company.slug
    company.update!(claimed: false)
    EditorialRefresh.new(@catalog).call
    assert_equal "Owner copy", company.reload.name
    company.update!(user: nil, source: "owner")
    result = EditorialRefresh.new(@catalog).call
    assert_equal "Owner copy", company.reload.name
    assert_equal "published", company.status
    assert_includes result.fetch(:skipped), company.slug
  end

  test "retires only explicitly named curator records and preserves relationships" do
    retired = Company.create!(slug: "retired-entry", name: "Retired entry", primary_category: "other", status: "published")
    untouched = Company.create!(slug: "unrelated-entry", name: "Unrelated entry", primary_category: "other", status: "published")
    @catalog["retired_companies"] = [ { "slug" => retired.slug, "reason" => "AI evidence unavailable" } ]
    EditorialRefresh.new(@catalog).call
    assert_equal "hidden", retired.reload.status
    assert_equal "published", untouched.reload.status
    assert Company.exists?(retired.id)
  end

  test "preserves verified claim edits before the owner finishes the wizard" do
    company = Company.create!(slug: @entry["slug"], name: "Owner copy", primary_category: "other",
      description: "Saved during the claim wizard", status: "published")
    claim = company.profile_claims.create!(email: "owner@example.org", review_status: "auto_approved", current_step: "story")
    @catalog["retired_companies"] = [ { "slug" => company.slug, "reason" => "Old record" } ]
    %w[auto_approved approved].each do |status|
      claim.update!(review_status: status)
      result = EditorialRefresh.new(@catalog).call
      assert_equal "Saved during the claim wizard", company.reload.description
      assert_equal "published", company.status
      assert_includes result.fetch(:skipped), company.slug
    end
  end

  test "rolls back the whole refresh if a later record is invalid" do
    @catalog["companies"] << @entry.merge("slug" => "invalid-entry", "primary_category" => "invalid")
    assert_raises(ActiveRecord::RecordInvalid) { EditorialRefresh.new(@catalog).call }
    assert_not Company.exists?(slug: @entry["slug"])
  end

  test "rejects unsafe source links" do
    @entry["source_references"].first["url"] = "javascript:alert(1)"
    assert_raises(ActiveRecord::RecordInvalid) { EditorialRefresh.new(@catalog).call }
    assert_not Company.exists?(slug: @entry["slug"])
  end

  test "guide refresh preserves publication history and repeated imports are no-ops" do
    published_at = Time.utc(2026, 5, 12, 12)
    guide = Guide.create!(slug: "existing-guide", title: "Original guide", body: "Original copy", status: "published", published_at: published_at)
    @catalog["guides"] = [ { "slug" => guide.slug, "title" => "Updated guide", "body" => "Researched copy",
      "status" => "published", "published_at" => "2026-09-08T12:00:00Z", "reviewed_on" => "2026-09-08" } ]
    EditorialRefresh.new(@catalog).call
    assert_equal published_at, guide.reload.published_at
    assert_equal "Researched copy", guide.body
    assert_equal Date.new(2026, 9, 8), guide.reviewed_on
    updated_at = guide.updated_at
    travel 1.day do
      EditorialRefresh.new(@catalog).call
    end
    assert_equal updated_at, guide.reload.updated_at
  end
end
