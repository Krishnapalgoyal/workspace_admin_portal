class OrganizationSwitchesController < ApplicationController
  before_action :authenticate_user!

  def update
    org = current_user.organizations.find(params[:organization_id])
    session[:current_organization_id] = org.id
    redirect_back fallback_location: root_path
  end
end
