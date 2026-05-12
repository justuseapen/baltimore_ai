class ContactMessage < ApplicationRecord
  MIN_BODY_LENGTH = 30

  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :body, presence: true, length: { minimum: MIN_BODY_LENGTH }

  normalizes :email, with: ->(email) { email.strip.downcase }
end
