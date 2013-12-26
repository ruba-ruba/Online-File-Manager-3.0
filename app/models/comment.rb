class Comment < ActiveRecord::Base
  attr_accessible :commentable_id, :commentable_type, :content, :user_id, :parent_id

  has_ancestry
  
  has_many :votes, :dependent => :destroy
  belongs_to :commentable, :polymorphic => true
  belongs_to :user

  validates :content, presence: true

end
