class Item < ActiveRecord::Base
  require 'RMagick'
  include ActiveModel::Validations
  include Magick

  attr_accessible :description, :folder_id, :title, :file, :file_file_name, :file_content_type, :file_file_size, :file_updated_at, :created_at, :updated_at, :user_id

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  after_update :reprocess_file, :if => :cropping?

  has_attached_file :file,
                    :url  => "/system/:attachment/:id/:style_:filename",
                    :path => ":rails_root/public/system/:attachment/:id/:style_:filename"

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
    Item.create(folder_id: folder, user_id: user, file: file)
  end

  def self.create_file(user, folder, name, host, data)
    file_params = {user_id: user, folder_id: folder, file_name: name}
    id = self.last_id_plus_one
    path = self.standart_path_for_new id
    unless File.directory?(path)
      FileUtils.mkdir_p(path)
    end
    #data = data.encode "UTF-8"
    file = File.new("#{path}/#{name}", 'wb:ASCII-8BIT')
    File.open("#{path}/#{name}", 'wb:ASCII-8BIT')  { |f| f.write(data) }
    Item.create_record(file_params, file)
  end

  def self.last_id_plus_one
    Item.last ? Item.last.id + 1 : 1
  end

  def self.standart_path_for_new id
    "#{Rails.root}/public/system/files/#{id}"
  end

  def extension
    self.file_file_name.index('.') ? self.file_file_name.split('.').last.downcase : ''
  end

  def file_name
    file_name_array = file_file_name.split('.')
    file_name_array.count >= 2 ? file_name_array.shift.to_s : file_name_array.to_s
  end

  def txt_or_html?
    %w(html txt).include?(self.extension)
  end

  def image?
    %w(jpg jpeg).include?(extension)
  end

  def reprocess_file(x,y,w,h)
    image = Image.read("#{self.file.path}").first
    new_image = image.crop!(x,y,w,h)
    id = Item.last_id_plus_one
    path = Item.standart_path_for_new id
    unless File.directory?(path)
      FileUtils.mkdir_p(path)
    end
    new_file_name = "#{self.file_name}_crop.#{self.extension}"
    new_image.write "#{path}/#{new_file_name}"
    file = File.open"#{path}/#{new_file_name}"
    file_params = {user_id: self.user_id, folder_id: self.folder_id}
    Item.create_record(file_params, file)
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