class StaticController < ApplicationController
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
