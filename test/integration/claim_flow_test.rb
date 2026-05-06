require "test_helper"

class ClaimFlowTest < ActionDispatch::IntegrationTest
  setup do
    @company = Company.create!(
      name: "Acme AI",
      primary_category: "applied_ai",
      website: "https://acme-ai.example",
      status: "published"
    )
  end

  test "scenario 1: domain-match auto-approves end-to-end" do
    assert_emails 1 do
      post "/claim/#{@company.slug}/verify",
           params: { email: "founder@acme-ai.example", claimant_name: "Jamie" }
    end
    follow_redirect!

    code = extract_code_from_last_email
    post "/claim/#{@company.slug}/code", params: { code: code }
    assert_redirected_to "/claim/#{@company.slug}/wizard/basics"

    claim = ProfileClaim.last
    assert_equal "auto_approved", claim.review_status
    assert_equal "domain_match",  claim.verification_method

    # Walk the wizard
    patch "/claim/#{@company.slug}/wizard/basics",
          params: { company: { tagline: "We do AI", website: @company.website, city: "Baltimore", state: "MD", founded_year: 2024 } }
    assert_redirected_to "/claim/#{@company.slug}/wizard/story"

    patch "/claim/#{@company.slug}/wizard/story",
          params: { company: { description: "Acme AI does cool things.", employee_count_bucket: "11-50" } }
    assert_redirected_to "/claim/#{@company.slug}/wizard/links"

    patch "/claim/#{@company.slug}/wizard/links",
          params: { company: { linkedin_url: "https://linkedin.com/company/acme-ai" } }
    assert_redirected_to "/claim/#{@company.slug}/wizard/tags"

    patch "/claim/#{@company.slug}/wizard/tags", params: { tag_ids: [] }
    assert_redirected_to "/companies/#{@company.slug}"

    @company.reload
    assert @company.claimed?, "company should be marked claimed"
    assert @company.user.present?, "company should have an owner"
    assert_equal "founder@acme-ai.example", @company.user.email
  end

  test "scenario 2: non-domain-match goes to admin queue" do
    post "/claim/#{@company.slug}/verify",
         params: { email: "different@gmail.com", claimant_name: "Jamie" }
    follow_redirect!

    code = extract_code_from_last_email
    assert_emails 1 do  # admin notification
      post "/claim/#{@company.slug}/code", params: { code: code }
    end

    claim = ProfileClaim.last
    assert_equal "manual_review", claim.verification_method
    assert_equal "pending_review", claim.review_status
    assert_not @company.reload.claimed?, "company should NOT be claimed yet"
  end

  test "scenario 3: claim is blocked when company is already claimed" do
    @company.update!(claimed: true)
    post "/claim/#{@company.slug}/verify",
         params: { email: "anyone@acme-ai.example", claimant_name: "Late" }
    assert_redirected_to "/companies/#{@company.slug}"
    follow_redirect!
    assert_match(/already been claimed/i, flash[:alert].to_s)
  end

  test "scenario 4: rate-limit blocks rapid resends within cooldown" do
    post "/claim/#{@company.slug}/verify",
         params: { email: "founder@acme-ai.example", claimant_name: "Jamie" }
    follow_redirect!  # consume first redirect

    post "/claim/#{@company.slug}/verify",
         params: { email: "founder@acme-ai.example", claimant_name: "Jamie" }
    assert_redirected_to "/claim/#{@company.slug}"
    follow_redirect!
    assert_match(/Slow down/i, flash[:alert].to_s)
  end

  test "scenario 5: wizard is blocked without a verified claim in session" do
    get "/claim/#{@company.slug}/wizard/basics"
    assert_redirected_to "/claim/#{@company.slug}"
    follow_redirect!
    assert_match(/verify your email/i, flash[:alert].to_s)
  end

  private

  def extract_code_from_last_email
    body = ActionMailer::Base.deliveries.last.text_part.body.to_s
    body.match(/(\d{6})/)[1]
  end
end
