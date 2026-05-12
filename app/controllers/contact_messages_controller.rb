class ContactMessagesController < ApplicationController
  def create
    # Honeypot: real users leave this field blank; bots fill it.
    if params[:company_url].present?
      redirect_to contact_path, notice: "Thanks — we'll be in touch." and return
    end

    @contact_message = ContactMessage.new(contact_message_params)
    @contact_message.ip_address = request.remote_ip
    @contact_message.user_agent = request.user_agent

    if @contact_message.save
      ContactMessageMailer.notify_admin(@contact_message).deliver_later
      redirect_to contact_path, notice: "Thanks — we'll be in touch."
    else
      flash.now[:alert] = @contact_message.errors.full_messages.to_sentence
      render "static/contact", status: :unprocessable_entity
    end
  end

  private

  def contact_message_params
    params.expect(contact_message: [ :name, :email, :subject, :body ])
  end
end
