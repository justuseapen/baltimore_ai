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
    parts.compact.push("Baltimore.ai").join(" · ")
  end
end
