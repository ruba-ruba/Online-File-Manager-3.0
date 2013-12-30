class Item < ActiveRecord::Base
  require 'RMagick'
  include ActiveModel::Validations
  include Magick

  attr_accessible :description, :folder_id, :title, :file, :file_file_name, :file_content_type, :file_file_size, :file_updated_at, :created_at, :updated_at, :user_id

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  after_update :reprocess_file, :if => :cropping?
  
  has_attached_file :file,
                    :url  => "/system/:attachment/:id/:style_:filename",
                    :path => ":rails_root/public/system/:attachment/:id/:style_:filename",
                    :processors => [:cropper]

  belongs_to :folder
  belongs_to :user
  has_many :comments, :as => :commentable, dependent: :destroy

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

  def extension
    self.file_file_name.index('.') ? self.file_file_name.split('.').last.downcase : ''
  end

  def txt_or_html?
    %w(html txt).include?(self.extension)
  end

  def image?
    %w(jpg jpeg).include?(extension)
  end

  def reprocess_file
    image = Image.read("#{self.file.path}").first
    face = image.crop!(270,55,194,194)
    face.write("/home/deployer/test_proj/Online-File-Manager-3.0/public/system/files/83/new.jpg")
  end

  def check_quota
    if self.file.present?
      current_file_size = self.file_file_size
      previouse_size = self.user.items.sum(:file_file_size)
      errors.add(:limit, 'you reached limit of quota') if self.user.quota < previouse_size + current_file_size
    else
      false
    end
  end

end