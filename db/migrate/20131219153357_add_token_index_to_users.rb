class AddTokenIndexToUsers < ActiveRecord::Migration
  def up
    add_index :users, :token
  end
  def down
    remove_index :users, :column => :token
  end
end
