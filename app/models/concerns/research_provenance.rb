module ResearchProvenance
  extend ActiveSupport::Concern

  included do
    validate :valid_source_references
  end

  private

  def valid_source_references
    unless source_references.is_a?(Array)
      errors.add(:source_references, "must be a list")
      return
    end

    source_references.each do |source|
      valid = source.is_a?(Hash) && source["title"].present?
      uri = URI.parse(source["url"].to_s) if valid
      valid &&= uri.is_a?(URI::HTTP) && uri.host.present?
      errors.add(:source_references, "must include a title and an HTTP(S) URL") unless valid
    rescue URI::InvalidURIError
      errors.add(:source_references, "contains an invalid URL")
    end
  end
end
