module Google
  class OauthController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin!
    before_action :ensure_organization_selected
    before_action :ensure_not_already_connected!, only: :connect

    def connect
      client = oauth_client
      redirect_to client.authorization_uri.to_s, allow_other_host: true
    end

    def callback
      client = oauth_client(code: params[:code])
      response = client.fetch_access_token!

      workspace = current_organization.google_workspace ||
                  current_organization.build_google_workspace

      workspace.update!(
        access_token: response["access_token"],
        refresh_token: response["refresh_token"] || workspace.refresh_token,
        expires_at: Time.current + response["expires_in"].to_i.seconds,
        scopes: GOOGLE_ADMIN_SCOPES.join(","),
        connected: true
      )

      redirect_to dashboard_path,
        notice: "Google Workspace connected for #{current_organization.name}"
    end

    private

    def oauth_client(code: nil)
      Signet::OAuth2::Client.new(
        client_id: ENV["GOOGLE_CLIENT_ID"],
        client_secret: ENV["GOOGLE_CLIENT_SECRET"],
        authorization_uri: "https://accounts.google.com/o/oauth2/auth",
        token_credential_uri: "https://oauth2.googleapis.com/token",
        scope: GOOGLE_ADMIN_SCOPES,
        redirect_uri: ENV["GOOGLE_REDIRECT_URI"],
        code: code,
        access_type: "offline",
        prompt: "consent"
      )
    end

    def ensure_not_already_connected!
      if current_organization.google_connected?
        redirect_to dashboard_path,
          alert: "Google Workspace already connected for this organization"
      end
    end
  end
end
