class Vote < ActiveRecord::Base
  attr_accessible :comment_id, :user_id

  belongs_to :user
  belongs_to :comment

  validates :user_id, uniqueness: { scope: :comment_id }

  # after_create :update_comments_counter


  # def update_comments_counter
  #   binding.pry
  # end

end
