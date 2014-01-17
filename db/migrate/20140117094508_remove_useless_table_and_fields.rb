class RemoveUselessTableAndFields < ActiveRecord::Migration
  def change
    drop_table :duplicates
  end
end
