class Tag < ApplicationRecord
  has_many :company_tags, dependent: :destroy
  has_many :companies, through: :company_tags

  validates :slug, presence: true, uniqueness: true, format: { with: /\A[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\z/ }
  validates :name, presence: true

  before_validation :generate_slug, on: :create

  def to_param
    slug
  end

  private

  def generate_slug
    self.slug = name.to_s.parameterize if slug.blank? && name.present?
  end
end
