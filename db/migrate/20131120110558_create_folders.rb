class CreateFolders < ActiveRecord::Migration
  def change
    create_table :folders do |t|
      t.string :title
      t.string :description
      t.references :user

      t.timestamps
    end
    add_index :folders, :user_id
  end
end
