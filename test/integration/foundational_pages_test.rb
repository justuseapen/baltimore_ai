require "test_helper"

class FoundationalPagesTest < ActionDispatch::IntegrationTest
  PAGES = {
    "/about" => "About Baltimore.ai",
    "/editorial-standards" => "Editorial Standards",
    "/how-it-works" => "How Baltimore.ai works",
    "/contact" => "Get in touch",
    "/privacy" => "Privacy",
    "/terms" => "Terms of use"
  }.freeze

  test "all six foundational pages return 200 with the expected H1" do
    PAGES.each do |path, expected_h1|
      get path
      assert_response(:success, "expected #{path} to return 200")
      assert_match(expected_h1, response.body, "expected #{path} body to include '#{expected_h1}'")
    end
  end

  test "every foundational page emits the og:image tag" do
    PAGES.each_key do |path|
      get path
      assert_match(%r{<meta property="og:image" content=".*og-default-[a-f0-9]+\.png"}, response.body,
        "expected #{path} to emit og:image with the static placeholder")
    end
  end

  test "every foundational page is linked from the footer" do
    get root_path
    PAGES.each_key do |path|
      assert_select("footer a[href='#{path}']", minimum: 1)
    end
  end
end
