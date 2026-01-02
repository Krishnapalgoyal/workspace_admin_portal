class OrganizationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @organizations = current_user.organizations
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(org_params)

    if @organization.save
      OrganizationMembership.create!(
        user: current_user,
        organization: @organization,
        role: :owner
      )

      session[:current_organization_id] = @organization.id
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def org_params
    params.require(:organization).permit(:name)
  end
end
