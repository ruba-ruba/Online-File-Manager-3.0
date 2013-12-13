class Item < ActiveRecord::Base
  attr_accessible :description, :folder_id, :title, :file, :file_file_name, :file_content_type, :file_file_size, :file_updated_at, :created_at, :updated_at, :user_id
  

  has_attached_file :file,
                    :url  => "/system/:attachment/:id/:style_:filename",
                    :path => ":rails_root/public/system/:attachment/:id/:style_:filename"

  belongs_to :folder
  belongs_to :user

  def self.file_name(link, host)
    case
    when link.split('/').last == host
      "#{link.gsub('/','').gsub(':','')}.html"
    else
      "#{link.gsub('/','').gsub(':','')}.html"
    end
  end 
  
  def self.create_record(params, file)
    name = params[:file_name]
    folder = params[:folder_id]
    user = params[:user_id]
    size = File.size(file)
    type = name.split('.').last
    date = Time.now
    Item.create(title: name, folder_id: folder, file_file_name: name, file_content_type: type, file_file_size: size, file_updated_at: date, user_id: user)
  end

  def self.create_file(user, folder, name, host, data)
    file_params = {user_id: user, folder_id: folder, file_name: name}
    id = Item.last.id+1
    path = "public/stystem/#{id}"
    dirname = ("#{Rails.root}/#{path}")
    unless File.directory?(dirname)
      FileUtils.mkdir_p(dirname)
    end
    data = data.encode "UTF-8"
    file = File.new("#{Rails.root}/#{path}/#{name}", 'wb+')
    File.open("#{Rails.root}/#{path}/#{name}", 'w+')  { |f| f.write(data)  }
    Item.create_record(file_params, file)
  end

end
