class AddQuotaToUsers < ActiveRecord::Migration
  def change
    add_column :users, :quota, :integer, :default => 209_715_200
  end
end
