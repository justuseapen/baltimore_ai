class AutoRejectStalePendingClaimsJob < ApplicationJob
  queue_as :default

  def perform
    ProfileClaim.stale_pending.find_each do |claim|
      claim.update!(
        review_status: "rejected",
        reviewed_by: "system:auto-reject",
        reviewed_at: Time.current
      )
    end
  end
end
