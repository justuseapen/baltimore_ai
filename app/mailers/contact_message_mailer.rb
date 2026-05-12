class ContactMessageMailer < ApplicationMailer
  def notify_admin(contact_message)
    @contact_message = contact_message

    mail(
      to: ENV.fetch("ADMIN_EMAIL", "admin@baltimore.ai"),
      reply_to: contact_message.email,
      subject: "[Baltimore.ai] Contact: #{contact_message.subject.presence || 'no subject'}"
    )
  end
end
