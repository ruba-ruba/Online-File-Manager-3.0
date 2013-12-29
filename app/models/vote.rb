class Vote < ActiveRecord::Base
  attr_accessible :comment_id, :user_id, :vote_type

  belongs_to :user
  belongs_to :comment

  validates :user_id, uniqueness: { scope: :comment_id }

end
