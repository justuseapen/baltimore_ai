class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch("MAIL_FROM", "Baltimore.ai <hello@baltimore.ai>")
  layout "mailer"
end
