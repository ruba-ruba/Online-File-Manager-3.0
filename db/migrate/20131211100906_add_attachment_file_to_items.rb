class AddAttachmentFileToItems < ActiveRecord::Migration
  def self.up
    change_table :items do |t|
      t.attachment :file
    end
  end

  def self.down
    drop_attached_file :items, :file
  end
end
