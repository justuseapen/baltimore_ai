class User < ApplicationRecord
  ROLES = %w[owner admin].freeze

  has_secure_password
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
end
