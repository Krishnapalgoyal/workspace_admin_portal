class ApplicationController < ActionController::Base
  before_action :switch_tenant

  private

  def switch_tenant
    return unless current_organization
    Apartment::Tenant.switch!(current_organization.tenant_name)
  end

  def current_organization
    return unless session[:current_organization_id]
    @current_organization ||= Organization.find(session[:current_organization_id])
  end

  def current_membership
    return unless current_user && current_organization

    @current_membership ||= OrganizationMembership.find_by(
      user: current_user,
      organization: current_organization
    )
  end

  def require_owner!
    redirect_to root_path, alert: "Access denied" unless current_membership&.owner?
  end

  def require_admin!
    redirect_to root_path, alert: "Access denied" unless current_membership&.owner? || current_membership&.admin?
  end

  helper_method :current_membership

  helper_method :current_organization
end
