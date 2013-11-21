class Folder < ActiveRecord::Base
  attr_accessible :title, :parent_id, :parent, :ancestry, :folder, :description

  attr_accessor :folder

  has_ancestry

  has_many :items, dependent: :destroy
  belongs_to :user

  validates :title, presence: true

end
