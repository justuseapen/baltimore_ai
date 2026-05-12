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
    host = request.base_url
    body = <<~ROBOTS
      User-agent: *
      Allow: /
      Disallow: /admin
      Disallow: /claim
      Disallow: /up

      Sitemap: #{host}/sitemap.xml.gz
    ROBOTS
    render plain: body, content_type: "text/plain"
  end
end
