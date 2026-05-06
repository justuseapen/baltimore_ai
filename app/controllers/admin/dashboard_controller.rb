class Admin::DashboardController < Admin::BaseController
  def index
    @pending_count = ProfileClaim.pending_review.count
    @stale_count   = ProfileClaim.stale_pending.count
    @total_companies = Company.count
    @published_companies = Company.published.count
    @claimed_companies = Company.where(claimed: true).count
  end
end
