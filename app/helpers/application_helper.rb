module ApplicationHelper
  CATEGORY_LABELS = {
    "applied_ai" => "Applied AI",
    "infrastructure" => "AI Infrastructure",
    "research" => "Research",
    "consulting" => "AI Consulting",
    "healthcare_ai" => "Healthcare AI",
    "govtech" => "GovTech",
    "edtech" => "EdTech",
    "creative_ai" => "Creative AI",
    "robotics" => "Robotics",
    "other" => "Other"
  }.freeze

  RESOURCE_TYPE_LABELS = {
    "lab" => "Research Labs",
    "accelerator" => "Accelerators & Incubators",
    "program" => "Programs & Press",
    "university" => "Universities",
    "event_series" => "Communities & Events"
  }.freeze

  def category_label(slug)
    CATEGORY_LABELS[slug.to_s] || slug.to_s.titleize
  end

  def resource_type_label(slug)
    RESOURCE_TYPE_LABELS[slug.to_s] || slug.to_s.titleize
  end

  def page_title(*parts)
    suffix = " · Baltimore.ai"
    title = parts.compact_blank.join(" · ")
    title.present? ? title.truncate(60 - suffix.length, separator: " ") + suffix : "Baltimore.ai"
  end

  def render_markdown(text)
    return "" if text.blank?
    html = Commonmarker.to_html(text, options: { extension: { table: true, strikethrough: true, autolink: true } })
    sanitize(html, tags: self.class.sanitized_allowed_tags.to_a + %w[table thead tbody tfoot tr th td],
      attributes: self.class.sanitized_allowed_attributes.to_a + %w[id aria-hidden])
  end
end
