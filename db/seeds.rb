# Versioned editorial content. Owner-managed company listings are preserved.
# Production content-only updates use: bin/rails content:refresh
if (admin_email = ENV["ADMIN_EMAIL"]).present?
  admin = User.find_or_initialize_by(email: admin_email)
  admin.role = "admin"
  admin.save!
end

result = EditorialRefresh.from_files.call
puts "Published: #{Company.published.count} companies, #{Resource.published.count} resources, #{Guide.published.count} guides"
puts "Preserved company-managed listings: #{result.fetch(:skipped).join(', ')}" if result.fetch(:skipped).any?
