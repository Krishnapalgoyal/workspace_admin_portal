class OrganizationMembersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!

  def index
    @memberships = current_organization.organization_memberships.includes(:user)
  end

  def create
    user = User.find_by(email: params[:email])

    unless user
      redirect_to organization_members_path, alert: "User not found"
      return
    end

    OrganizationMembership.create!(
      user: user,
      organization: current_organization,
      role: params[:role]
    )

    redirect_to organization_members_path, notice: "Member added"
  end
end
