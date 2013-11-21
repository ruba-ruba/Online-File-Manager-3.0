class Folder < ActiveRecord::Base
  attr_accessible :title, :parent_id, :parent, :ancestry, :folder, :description

  attr_accessor :folder

  has_ancestry

  has_many :items, dependent: :destroy
  belongs_to :user

  validates :title, presence: true

def path(root = nil)
    if self.parent.nil?
      nil
    else
      result = []
      folder = self.parent
      while folder != nil
        result << folder.title
        folder = folder == root ? nil : folder.parent
      end
      result.reverse.join("/")
    end
  end

end
