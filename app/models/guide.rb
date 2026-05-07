class Guide < ApplicationRecord
  STATUSES = %w[draft published hidden].freeze

  validates :slug, presence: true, uniqueness: true, format: { with: /\A[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\z/ }
  validates :title, presence: true
  validates :body, presence: true
  validates :status, inclusion: { in: STATUSES }

  before_validation :generate_slug, on: :create

  scope :published, -> { where(status: "published").where.not(published_at: nil) }

  def to_param
    slug
  end

  private

  def generate_slug
    self.slug = title.to_s.parameterize if slug.blank? && title.present?
  end
end
