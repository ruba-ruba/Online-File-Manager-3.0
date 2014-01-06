class ChangeColumnToComments < ActiveRecord::Migration
  def change
    #change_column :comments, :user_id, :integer
    #execute "ALTER TABLE comments ALTER COLUMN user_id TYPE integer"
    connection.execute(%q{
      alter table comments
      alter column user_id
      type integer using cast(user_id as integer)
    })
  end
end
