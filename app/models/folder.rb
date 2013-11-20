class Folder < ActiveRecord::Base
  belongs_to :user
  attr_accessible :description, :title

  has_ancestry
end
