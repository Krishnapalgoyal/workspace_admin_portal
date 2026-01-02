module Admin
  class GoogleUsersController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin!
    before_action :ensure_google_connected

    def index
      @users = Google::AdminDirectoryService.users
    end
  end
end
