class Organization < ApplicationRecord
  has_many :organization_memberships, dependent: :destroy
  has_many :users, through: :organization_memberships

  after_create :create_tenant

  def tenant_name
    "org_#{id}"
  end

  private

  def create_tenant
    Apartment::Tenant.create(tenant_name)
  end
end
