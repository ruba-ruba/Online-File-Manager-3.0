class Item < ActiveRecord::Base
  require 'RMagick'
  require 'csv'
  include ActiveModel::Validations
  include Magick

  attr_accessible :description, :folder_id, :title, :file, :file_file_name, :file_content_type, :file_file_size, :file_updated_at, :created_at, :updated_at, :user_id

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  after_save :parse_map, :if => :is_map?

  has_attached_file :file,
                    :url  => "/system/:attachment/:id/:style_:filename",
                    :path => ":rails_root/public/system/:attachment/:id/:style_:filename"

  belongs_to :folder
  belongs_to :user
  belongs_to :duplicate
  has_many :comments, :as => :commentable, dependent: :destroy
  has_many :locations, dependent: :destroy

  validates :file, :attachment_presence => true
  validates_uniqueness_of :file_file_name, :scope => :folder_id
  validate :check_quota

  scope :root, where(:folder_id => nil)
  scope :duplicates, where('`items`.`duplicate_id` IS NOT NULL').order(:file_file_name)

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

  def send_mail(mail)
    FileManagerMailer.send_file(
      mail[:recipient],
      mail[:subject],
      self.file.url,
      self.file_file_name
    ).deliver
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
    %w(jpg jpeg png).include?(extension)
  end

  def reprocess_file(x,y,w,h)
    image = Image.read(self.file.url).first
    new_image = image.crop!(x,y,w,h)
    id = Item.last_id_plus_one
    path = Item.standart_path_for_new id
    unless File.directory?(path)
      FileUtils.mkdir_p(path)
    end
    new_file_name = "#{self.file_name}_crop_#{Date.today.to_time.to_i}.#{self.extension}"
    new_image.write "#{path}/#{new_file_name}"
    file = File.open"#{path}/#{new_file_name}"
    file_params = {user_id: self.user_id, folder_id: self.folder_id}
    Item.create_record(file_params, file)
  end

  def check_quota
    if file.present?
      current_file_size = file_file_size
      previouse_size = user.space_used
      errors.add(:limit, 'you reached limit of quota') if user.quota < previouse_size + current_file_size
    else
      false
    end
  end

  def parse_map
    headers = ["address","latitude","longitude"]
    CSV.parse(self.file.queued_for_write[:original].read) do |row|
      place = Location.new(:item_id => id)
      headers.each_with_index do |key, idx|
        place.send("#{key}=", row[idx])
      end
      place.save
    end
    self.file.queued_for_write[:original].rewind
  end

  def is_map?
    extension.downcase == "csv" && file_name.downcase == "map"
  end
end
