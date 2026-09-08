class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  stale_when_importmap_changes

  helper_method :canonical_url, :public_site_url, :current_user, :signed_in?

  private

  def canonical_url(path = request.path)
    base = if Rails.env.production? || ENV["APP_HOST"].present?
      public_site_url
    else
      request.base_url
    end
    # Use only the path, so query parameters and absolute or protocol-relative
    # inputs cannot change the canonical origin.
    clean_path = URI.parse(path.to_s).path.to_s.sub(%r{\A/*}, "/")
    "#{base}#{clean_path}"
  end

  def public_site_url
    uri = URI.parse(ENV["APP_HOST"].presence || "https://baltimore.ai")
    return "https://baltimore.ai" unless uri.is_a?(URI::HTTP) && uri.host.present? && uri.userinfo.nil?

    uri.path = ""
    uri.query = nil
    uri.fragment = nil
    uri.to_s.delete_suffix("/")
  rescue URI::InvalidURIError
    "https://baltimore.ai"
  end

  def current_user
    @current_user ||= authenticate_from_cookie
  end

  def signed_in?
    current_user.present?
  end

  def authenticate_from_cookie
    token = cookies.signed[:session_token]
    return nil if token.blank?
    User.find_by_session_token(token)
  end

  def sign_in_as(user)
    cookies.signed.permanent[:session_token] = {
      value: user.session_token,
      httponly: true,
      same_site: :lax,
      secure: Rails.env.production?
    }
    @current_user = user
  end

  def sign_out!
    cookies.delete(:session_token)
    @current_user = nil
  end

  def require_admin!
    redirect_to root_path, alert: "Not authorized." unless current_user&.admin?
  end
end
