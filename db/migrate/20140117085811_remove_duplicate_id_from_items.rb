class RemoveDuplicateIdFromItems < ActiveRecord::Migration
  def up
    remove_column :items, :duplicate_id
  end

  def down
    add_column :items, :duplicate_id, :integer
  end
end
