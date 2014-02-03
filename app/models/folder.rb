require 'zip'
class Folder < ActiveRecord::Base
  attr_accessible :title, :parent_id, :parent, :ancestry, :folder, :description
  attr_accessor :folder

  has_ancestry

  belongs_to :user
  has_many :items, dependent: :destroy
  has_many :comments, :as => :commentable, dependent: :destroy

  validates :title, presence: true
  validates_uniqueness_of :title, :scope => :ancestry

  def size 
    children.inject(items.pluck(:file_file_size).sum){|sum, i| sum += i.size}
  end

  def zip_archive author
    zip_filename = "#{Rails.root}/tmp/#{title}_archive_#{Time.now.strftime('%Y-%m-%d-%H%M%S-%N')}.zip"
    zip = Zip::File.open(zip_filename, Zip::File::CREATE) 
    zip.close
    add_to_zip(zip_filename)
    data = File.new(zip_filename)  
    result = Item.create_record({:user_id => author}, data)
    File.delete zip_filename
    result.file.url
  end

  def add_to_zip(zip_name, path = nil)
    zip = Zip::File.open(zip_name)
    new_path = path ? "#{path}/#{title}" : title
    zip.mkdir(new_path)
    zip.close
    if has_children?
      children.each { |e| e.add_to_zip(zip_name, new_path)}
    end
    items.each { |e| e.add_to_zip(zip_name, new_path)}
  end
end
