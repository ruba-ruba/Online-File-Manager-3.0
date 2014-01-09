class ChangeColumnToComments < ActiveRecord::Migration
  def change
    connection.execute(%q{
      alter table comments
      alter column user_id
      type integer using cast(user_id as integer)
    })
  end
end
