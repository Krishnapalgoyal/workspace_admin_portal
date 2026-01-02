module Google
  class TokenService
    def self.client
      account = GoogleAccount.first
      raise "Google not connected" unless account

      client = Signet::OAuth2::Client.new(
        client_id: ENV["GOOGLE_CLIENT_ID"],
        client_secret: ENV["GOOGLE_CLIENT_SECRET"],
        token_credential_uri: "https://oauth2.googleapis.com/token",
        refresh_token: account.refresh_token,
        access_token: account.access_token,
        expires_at: account.expires_at
      )

      if client.expired?
        response = client.refresh!
        account.update!(
          access_token: response["access_token"],
          expires_at: Time.current + response["expires_in"].seconds
        )
      end

      client
    end
  end
end
