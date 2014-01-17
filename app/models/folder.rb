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
end
