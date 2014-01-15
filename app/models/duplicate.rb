class Duplicate < ActiveRecord::Base
  attr_accessible :items

  has_many :items

  def self.find_duplicates
    Item.find_each do |target_item|
      duplicate_ids = Item.where(:duplicate_id => nil,
                              :file_file_name => target_item.file_file_name,
                              :file_file_size => target_item.file_file_size)
      if duplicate_ids.size > 1
        d = Duplicate.create
        Item.where(:id => duplicate_ids).each{|i| i.update_attribute(:duplicate_id, d.id)}
      end
    end
  end
end
