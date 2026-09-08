class StaticController < ApplicationController
  def about
  end

  def editorial_standards
  end

  def how_it_works
  end

  def contact
    @contact_message = ContactMessage.new
  end

  def privacy
  end

  def terms
  end

  def robots
    body = <<~ROBOTS
      User-agent: *
      Allow: /
      Disallow: /admin
      Disallow: /claim
      Disallow: /sign-in
      Disallow: /sign-out
      Disallow: /companies/*/edit
      Disallow: /up

      Sitemap: #{public_site_url}/sitemap.xml
    ROBOTS
    render plain: body, content_type: "text/plain"
  end
end
