class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  stale_when_importmap_changes

  helper_method :canonical_url

  private

  def canonical_url(path = request.path)
    URI.join(request.base_url, path).to_s
  end
end
