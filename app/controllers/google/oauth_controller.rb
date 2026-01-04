module Google
  class OauthController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin!

    def connect
      client = Signet::OAuth2::Client.new(
        client_id: ENV["GOOGLE_CLIENT_ID"],
        client_secret: ENV["GOOGLE_CLIENT_SECRET"],
        authorization_uri: "https://accounts.google.com/o/oauth2/auth",
        scope: GOOGLE_ADMIN_SCOPES,
        redirect_uri: ENV["GOOGLE_REDIRECT_URI"],
        access_type: "offline",
        prompt: "consent"
      )

      redirect_to client.authorization_uri.to_s, allow_other_host: true
    end

    def callback
      client = Signet::OAuth2::Client.new(
        client_id: ENV["GOOGLE_CLIENT_ID"],
        client_secret: ENV["GOOGLE_CLIENT_SECRET"],
        token_credential_uri: "https://oauth2.googleapis.com/token",
        redirect_uri: ENV["GOOGLE_REDIRECT_URI"],
        code: params[:code]
      )

      response = client.fetch_access_token!

      GoogleAccount.create!(
        access_token: response["access_token"],
        refresh_token: response["refresh_token"],
        expires_at: Time.current + response["expires_in"].to_i.seconds,
        scopes: GOOGLE_ADMIN_SCOPES.join(",")
      )

      redirect_to dashboard_path, notice: "Google Workspace connected successfully"
    end
  end
end
