# Imports only the explicitly curated records in a versioned research release.
# Company owners retain authority over their own copy and publication status.
class EditorialRefresh
  def self.from_files
    root = Rails.root.join("db/content")
    catalog = JSON.parse(root.join("catalog.json").read)
    catalog.fetch("guides").each do |guide|
      slug = guide.fetch("slug")
      raise ArgumentError, "Invalid guide slug" unless slug.match?(/\A[a-z0-9]+(?:-[a-z0-9]+)*\z/)
      guide["body"] = root.join("guides", "#{slug}.md").read
    end
    new(catalog)
  end

  def initialize(catalog)
    @catalog = catalog
    @skipped = []
  end

  def call
    ApplicationRecord.transaction do
      @catalog.fetch("companies").each { |attributes| import_company(attributes) }
      @catalog.fetch("resources").each { |attributes| import_record(Resource, attributes) }
      @catalog.fetch("guides").each { |attributes| import_record(Guide, attributes) }
      @catalog.fetch("retired_companies").each do |entry|
        company = Company.lock.find_by(slug: entry.fetch("slug"))
        next unless company
        next if owner_managed?(company)
        company.update!(status: "hidden") unless company.status == "hidden"
      end
    end
    { skipped: @skipped.uniq }
  end

  private

  def owner_managed?(company)
    managed = company.claimed? || company.user_id.present? || company.source != "curator" ||
      company.profile_claims.where(review_status: %w[auto_approved approved]).exists?
    @skipped << company.slug if managed
    managed
  end

  def import_company(attributes)
    company = Company.lock.find_or_initialize_by(slug: attributes.fetch("slug"))
    return if owner_managed?(company)

    # Omitted enrichment is unknown, rather than inherited from old seed guesses.
    company.assign_attributes({ founded_year: nil, employee_count_bucket: nil,
      linkedin_url: nil, github_url: nil, crunchbase_url: nil, twitter_url: nil }.merge(attributes.except("tags")))
    company.save! if company.changed?
    tags = attributes.fetch("tags", []).map do |slug|
      Tag.find_or_create_by!(slug: slug) { |tag| tag.name = slug.titleize }
    end
    company.tags = tags unless company.tag_ids.sort == tags.map(&:id).sort
  end

  def import_record(model, attributes)
    record = model.find_or_initialize_by(slug: attributes.fetch("slug"))
    # Preserve publication history: reviewed_on is the date of this research.
    values = attributes.except("published_at")
    values = { founded_year: nil }.merge(values) if model == Resource
    record.assign_attributes(values)
    record.published_at ||= attributes.fetch("published_at") if model == Guide
    record.save! if record.changed?
  end
end
