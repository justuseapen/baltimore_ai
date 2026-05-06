class ProfileClaim < ApplicationRecord
  VERIFICATION_CODE_TTL = (ENV.fetch("CLAIM_CODE_TTL_MINUTES", "15").to_i).minutes
  SEND_COOLDOWN = 60.seconds
  MAX_SENDS_PER_HOUR = 3
  PENDING_REVIEW_TTL = 30.days

  STEPS = %w[verify basics story links tags done].freeze
  REVIEW_STATUSES = %w[pending pending_review auto_approved approved rejected].freeze
  VERIFICATION_METHODS = %w[domain_match manual_review].freeze

  belongs_to :company

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :review_status, inclusion: { in: REVIEW_STATUSES }
  validates :current_step, inclusion: { in: STEPS }
  validates :verification_method, inclusion: { in: VERIFICATION_METHODS }, allow_nil: true
  validates :company_id, uniqueness: { scope: :email }

  normalizes :email, with: ->(email) { email.strip.downcase }

  scope :pending_review, -> { where(review_status: "pending_review") }
  scope :stale_pending, -> { pending_review.where("created_at < ?", PENDING_REVIEW_TTL.ago) }

  def generate_verification_code!
    code = format("%06d", SecureRandom.random_number(1_000_000))
    update!(
      verification_code_digest: BCrypt::Password.create(code),
      verification_code_sent_at: Time.current,
      verification_sends_count: rate_limit_count + 1
    )
    code
  end

  def verify_code(submitted)
    return false if verification_code_digest.blank?
    return false if verification_code_sent_at.nil?
    return false if Time.current > verification_code_sent_at + VERIFICATION_CODE_TTL
    BCrypt::Password.new(verification_code_digest) == submitted.to_s
  end

  def can_send_code?
    return true if verification_code_sent_at.nil?
    return false if verification_code_sent_at > SEND_COOLDOWN.ago
    rate_limit_count < MAX_SENDS_PER_HOUR
  end

  def cooldown_seconds_remaining
    return 0 if verification_code_sent_at.nil?
    remaining = (verification_code_sent_at + SEND_COOLDOWN - Time.current).to_i
    [ remaining, 0 ].max
  end

  def domain_matches_website?
    company_domain = company.domain
    return false if company_domain.blank?
    claimant_domain = email.to_s.split("@").last&.downcase
    return false if claimant_domain.blank?
    claimant_domain == company_domain.downcase
  end

  def approve_or_queue_review!
    if domain_matches_website?
      update!(verification_method: "domain_match", review_status: "auto_approved", verified_at: Time.current)
    else
      update!(verification_method: "manual_review", review_status: "pending_review", verified_at: Time.current)
    end
  end

  def approved?
    review_status.in?(%w[auto_approved approved])
  end

  private

  def rate_limit_count
    return 0 if verification_code_sent_at.nil?
    verification_code_sent_at < 1.hour.ago ? 0 : verification_sends_count.to_i
  end
end
