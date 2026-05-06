class SessionMailer < ApplicationMailer
  def magic_link(user, token)
    @user = user
    @url = sign_in_url(token: token)
    @ttl_minutes = User::MAGIC_LINK_TTL.in_minutes.to_i

    mail(
      to: user.email,
      subject: "Sign in to Baltimore.ai"
    )
  end
end
