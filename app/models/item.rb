class Item < ActiveRecord::Base
  attr_accessible :description, :folder_id, :title, :file, :file_file_name, :file_content_type, :file_file_size, :file_updated_at, :created_at, :updated_at, :user_id
  

  has_attached_file :file,
                    :url  => "/system/:attachment/:id/:style_:filename",
                    :path => ":rails_root/public/system/:attachment/:id/:style_:filename"

  belongs_to :folder
  belongs_to :user

  def self.create_record(params, file)
    binding.pry
    name = params[:file_name]
    folder = params[:folder_id]
    user = params[:user_id]
    size = File.size(file)
    type = name.split('.').last
    date = Time.now
    Item.create(title: name, folder_id: folder, file_file_name: name, file_content_type: type, file_file_size: size, file_updated_at: date, user_id: user)
  end
end
