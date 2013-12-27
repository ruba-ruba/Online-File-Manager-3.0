class RemoveTitleFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :title
  end
end
