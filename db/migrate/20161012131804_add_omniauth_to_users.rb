class AddOmniauthToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :headline, :string
    add_column :users, :linkedin_summary, :string
    add_column :users, :linkedin_picture_url, :string
    add_column :users, :linkedin_profile, :string
    add_column :users, :token, :string
    add_column :users, :token_expiry, :datetime
  end
end
