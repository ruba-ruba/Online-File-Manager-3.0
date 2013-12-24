class Item < ActiveRecord::Base
  include ActiveModel::Validations

  attr_accessible :description, :folder_id, :title, :file, :file_file_name, :file_content_type, :file_file_size, :file_updated_at, :created_at, :updated_at, :user_id
  
  has_attached_file :file,
                    :url  => "/system/:attachment/:id/:style_:filename",
                    :path => ":rails_root/public/system/:attachment/:id/:style_:filename"

  belongs_to :folder
  belongs_to :user

  validates :file, :attachment_presence => true
  validates_uniqueness_of :file_file_name, :scope => :folder_id
  validate :check_quota

  scope :root, where(:folder_id => nil)


  def self.file_name(link, host)
    case
    when link.split('/').last == host
      "index.html"
    when link.split('/').last.index('.') != nil
      link.split('/').last
    else
      link.split('/').last
    end
  end 
  
  def self.create_record(params, file)
    folder = params[:folder_id]
    user = params[:user_id]
    Item.create(title: name, folder_id: folder, user_id: user, file: file)
  end

  def self.create_file(user, folder, name, host, data)
    file_params = {user_id: user, folder_id: folder, file_name: name}
    id = Item.last ? Item.last.id + 1 : 1
    path = "public/system/files/#{id}"
    dirname = ("#{Rails.root}/#{path}")
    unless File.directory?(dirname)
      FileUtils.mkdir_p(dirname)
    end
    #data = data.encode "UTF-8"
    file = File.new("#{Rails.root}/#{path}/#{name}", 'wb:ASCII-8BIT')
    File.open("#{Rails.root}/#{path}/#{name}", 'wb:ASCII-8BIT')  { |f| f.write(data) }
    Item.create_record(file_params, file)
  end

  def item_format
    self.file_file_name.split('.').last.downcase
  end

  def txt_or_html?
    %w(html txt).include?(self.item_format)
  end

  def check_quota
    current_file_size = self.file_file_size || 0
    previouse_size = self.user.items.sum(:file_file_size)
    errors.add(:limit, 'you reached limit of quota') if self.user.quota < previouse_size + current_file_size
  end

end
