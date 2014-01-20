class ChangeUsersColomn < ActiveRecord::Migration
  def up
    change_column :users, :token, :string, null: false
  end
end
