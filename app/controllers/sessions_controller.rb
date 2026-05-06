class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email].to_s.strip.downcase)
    if user
      SessionMailer.magic_link(user, user.magic_link_token).deliver_later
    end
    # Always render the same response — don't leak whether an email is registered.
    render :sent
  end

  def verify
    user = User.find_by_magic_link_token(params[:token])
    if user
      sign_in_as(user)
      redirect_to(user.admin? ? admin_root_path : (user.company ? company_path(user.company) : root_path),
                  notice: "Signed in.")
    else
      redirect_to sign_in_request_path, alert: "That sign-in link is invalid or expired."
    end
  end

  def destroy
    sign_out!
    redirect_to root_path, notice: "Signed out."
  end
end
