class ChangeColumnToComments < ActiveRecord::Migration
   def change
    change_column :comments, :user_id, :integer
  end
end
