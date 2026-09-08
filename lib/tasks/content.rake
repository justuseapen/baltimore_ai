namespace :content do
  desc "Import the researched directory release, preserving company-managed listings"
  task refresh: :environment do
    result = EditorialRefresh.from_files.call
    puts "Published: #{Company.published.count} companies, #{Resource.published.count} resources, #{Guide.published.count} guides"
    puts "Preserved company-managed listings: #{result.fetch(:skipped).join(', ')}" if result.fetch(:skipped).any?
  end
end
