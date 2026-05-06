class User < ApplicationRecord
  ROLES = %w[owner admin].freeze
  MAGIC_LINK_TTL = 15.minutes
  SESSION_TTL = 30.days

  has_one :company, dependent: :nullify

  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :role, inclusion: { in: ROLES }

  normalizes :email, with: ->(email) { email.strip.downcase }

  def admin?
    role == "admin"
  end

  def owner?
    role == "owner"
  end

  def magic_link_token
    signed_id(purpose: :magic_link, expires_in: MAGIC_LINK_TTL)
  end

  def session_token
    signed_id(purpose: :session, expires_in: SESSION_TTL)
  end

  def self.find_by_magic_link_token(token)
    find_signed(token, purpose: :magic_link)
  end

  def self.find_by_session_token(token)
    find_signed(token, purpose: :session)
  end
end
