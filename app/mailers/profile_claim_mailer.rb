class ProfileClaimMailer < ApplicationMailer
  def verification_code(claim, code)
    @claim = claim
    @company = claim.company
    @code = code
    @ttl_minutes = ProfileClaim::VERIFICATION_CODE_TTL.in_minutes.to_i

    mail(
      to: claim.email,
      subject: "Your Baltimore.ai verification code: #{code}"
    )
  end

  def admin_new_claim(claim)
    @claim = claim
    @company = claim.company

    mail(
      to: ENV.fetch("ADMIN_EMAIL", "admin@baltimore.ai"),
      subject: "[Baltimore.ai] Manual review needed: #{@company.name}"
    )
  end

  def welcome(user, company)
    @user = user
    @company = company

    mail(
      to: user.email,
      subject: "#{@company.name} is now live on Baltimore.ai"
    )
  end
end
