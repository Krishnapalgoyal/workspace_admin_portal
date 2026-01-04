class Organization < ApplicationRecord
  has_many :organization_memberships, dependent: :destroy
  has_many :users, through: :organization_memberships

  has_one :google_workspace, dependent: :destroy

  after_create :create_tenant

  def google_connected?
    google_workspace&.connected?
  end

  def tenant_name
    "org_#{id}"
  end

  private

  def create_tenant
    Apartment::Tenant.create(tenant_name)
  end
end
