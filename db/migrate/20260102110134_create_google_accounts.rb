class CreateGoogleAccounts < ActiveRecord::Migration[8.1]
  def change
    create_table :google_accounts do |t|
      t.string :access_token
      t.string :refresh_token
      t.datetime :expires_at
      t.text :scopes

      t.timestamps
    end
  end
end
