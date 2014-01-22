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
    tmp_filename = "#{Rails.root}/tmp/#{title}_archive" <<
                    Time.now.strftime('%Y-%m-%d-%H%M%S-%N').to_s <<   
                    ".zip"
    zip = Zip::File.open(tmp_filename, Zip::File::CREATE) 
    zip.mkdir(title)
    zip.close
    items.each { |e|
      zip = Zip::File.open(tmp_filename)
      temp_file = e.local_copy
      zip.add("#{title}/#{e.file_file_name}", temp_file)
      zip.close
      File.delete temp_file
    }
    data = File.new(tmp_filename)  
    result = Item.create_record({:user_id => author}, data)
    File.delete tmp_filename
    result.file.url
  end
end
