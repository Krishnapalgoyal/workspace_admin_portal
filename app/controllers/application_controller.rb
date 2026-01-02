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

  helper_method :current_organization
end
