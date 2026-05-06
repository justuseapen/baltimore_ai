class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  stale_when_importmap_changes

  helper_method :canonical_url, :current_user, :signed_in?

  private

  def canonical_url(path = request.path)
    URI.join(request.base_url, path).to_s
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
