class CreateGoogleWorkspaces < ActiveRecord::Migration[8.1]
  def change
    create_table :google_workspaces do |t|
      t.references :organization, null: false, foreign_key: true
      t.string :google_customer_id
      t.text :access_token
      t.text :refresh_token
      t.datetime :expires_at
      t.boolean :connected, default: false, null: false

      t.timestamps
    end
  end
end
