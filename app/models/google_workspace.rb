class GoogleWorkspace < ApplicationRecord
  belongs_to :organization

  def expired?
    expires_at.present? && expires_at < Time.current
  end
end
