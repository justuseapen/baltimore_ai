class Company < ApplicationRecord
  CATEGORIES = %w[
    applied_ai
    infrastructure
    research
    consulting
    healthcare_ai
    govtech
    edtech
    creative_ai
    robotics
    other
  ].freeze

  STATUSES = %w[draft published hidden].freeze

  belongs_to :user, optional: true
  has_many :company_tags, dependent: :destroy
  has_many :tags, through: :company_tags
  has_many :profile_claims, dependent: :destroy

  validates :slug, presence: true, uniqueness: true, format: { with: /\A[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\z/ }
  validates :name, presence: true
  validates :primary_category, inclusion: { in: CATEGORIES }
  validates :status, inclusion: { in: STATUSES }
  validates :website, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]), allow_blank: true }

  before_validation :generate_slug, on: :create

  scope :published, -> { where(status: "published") }
  scope :indexable, -> { published.where.not(description: [ nil, "" ]).where.not(website: [ nil, "" ]) }
  scope :by_category, ->(category) { where(primary_category: category) }

  def to_param
    slug
  end

  def claimed?
    claimed
  end

  def domain
    return nil if website.blank?
    URI.parse(normalize_url(website)).host&.sub(/\Awww\./, "")
  rescue URI::InvalidURIError
    nil
  end

  private

  def generate_slug
    return if slug.present?
    base = name.to_s.parameterize
    candidate = base
    suffix = 2
    while Company.where(slug: candidate).where.not(id: id).exists?
      candidate = "#{base}-#{suffix}"
      suffix += 1
    end
    self.slug = candidate
  end

  def normalize_url(url)
    url.match?(%r{\Ahttps?://}) ? url : "https://#{url}"
  end
end
