class CreateDuplicates < ActiveRecord::Migration
  def change
    create_table :duplicates do |t|
      t.references :item

      t.timestamps
    end
    add_index :duplicates, :item_id
  end
end
