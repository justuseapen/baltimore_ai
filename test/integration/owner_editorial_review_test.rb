require "test_helper"

class OwnerEditorialReviewTest < ActionDispatch::IntegrationTest
  setup do
    @owner = User.create!(email: "owner@example.org")
    @company = Company.create!(name: "Reviewed company", primary_category: "applied_ai",
      user: @owner, claimed: true, status: "published", tagline: "Original copy",
      website: "https://example.org", reviewed_on: Date.new(2026, 9, 8),
      source_references: [ { title: "Source", url: "https://example.org" } ],
      location_note: "Original location", meta_description: "Original metadata")
    get sign_in_path(token: @owner.magic_link_token)
  end

  test "owner changes remove the editorial stamp and stale metadata" do
    patch company_path(@company), params: { company: { tagline: "Owner's new copy" } }
    assert_redirected_to company_path(@company)
    assert_equal "Owner's new copy", @company.reload.tagline
    assert_nil @company.reviewed_on
    assert_empty @company.source_references
    assert_nil @company.location_note
    assert_nil @company.meta_description
    get company_path(@company)
    assert_select "section[aria-label='Research sources']", count: 0
    assert_select "meta[name='description'][content=?]", "Owner's new copy"
  end

  test "tag-only changes also remove the editorial stamp" do
    tag = Tag.create!(name: "Machine learning", slug: "machine-learning")
    patch company_path(@company), params: { company: { tagline: @company.tagline }, tag_ids: [ tag.id ] }
    assert_redirected_to company_path(@company)
    assert_equal [ tag.id ], @company.reload.tag_ids
    assert_nil @company.reviewed_on
  end

  test "no-op owner saves preserve the source review" do
    patch company_path(@company), params: { company: { tagline: @company.tagline }, tag_ids: [] }
    assert_redirected_to company_path(@company)
    assert_equal Date.new(2026, 9, 8), @company.reload.reviewed_on
  end

  test "failed owner edits preserve stored research" do
    patch company_path(@company), params: { company: { website: "invalid" } }
    assert_response :unprocessable_entity
    assert_equal Date.new(2026, 9, 8), @company.reload.reviewed_on
    assert_equal "https://example.org", @company.website
  end

  test "an unavailable tag rolls back copy and provenance changes" do
    missing_id = Tag.maximum(:id).to_i + 1
    patch company_path(@company), params: { company: { tagline: "Unsaved owner copy" }, tag_ids: [ missing_id ] }
    assert_response :unprocessable_entity
    assert_equal "Original copy", @company.reload.tagline
    assert_equal Date.new(2026, 9, 8), @company.reviewed_on
    assert_equal "https://example.org", @company.source_references.first.fetch("url")
  end
end
