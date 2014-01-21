class AddExpiresAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :expires_at, :datetime
    add_column :users, :active, :boolean, null: false, default: true
  end
end
