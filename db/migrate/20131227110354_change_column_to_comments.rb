class ChangeColumnToComments < ActiveRecord::Migration
  def change
    #change_column :comments, :user_id, :integer
    execute "ALTER TABLE comments ALTER COLUMN user_id TYPE integer"
  end
end
