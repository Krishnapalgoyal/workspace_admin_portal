class OrganizationMembership < ApplicationRecord
  belongs_to :user
  belongs_to :organization

  # enum role: { owner: 0, admin: 1, member: 2 }
end
