class Item < ActiveRecord::Base
  attr_accessible :description, :folder_id, :title, :file, :file_file_name, :file_content_type, :file_file_size, :file_updated_at, :created_at, :updated_at 
  

  has_attached_file :file, :default_style => :thumb

  belongs_to :folder
  belongs_to :user
end
