class AddDuplicateIdToItems < ActiveRecord::Migration
  def change
    add_column :items, :duplicate_id, :integer
  end
end
