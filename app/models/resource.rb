class Resource < ApplicationRecord
  TYPES = %w[lab accelerator program university event_series].freeze
  STATUSES = %w[draft published hidden].freeze

  validates :slug, presence: true, uniqueness: true, format: { with: /\A[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\z/ }
  validates :name, presence: true
  validates :resource_type, inclusion: { in: TYPES }
  validates :status, inclusion: { in: STATUSES }

  before_validation :generate_slug, on: :create

  scope :published, -> { where(status: "published") }

  def to_param
    slug
  end

  private

  def generate_slug
    self.slug = name.to_s.parameterize if slug.blank? && name.present?
  end
end
