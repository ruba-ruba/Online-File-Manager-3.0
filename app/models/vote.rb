class Vote < ActiveRecord::Base
  attr_accessible :comment_id, :user_id, :vote_type

  belongs_to :user
  belongs_to :comment

  validates :user_id, uniqueness: { scope: :comment_id }

  def self.revote(vote_type, comment_id, user_id)
    comment = Comment.find(comment_id)
    self.where(:user_id => user_id, :comment_id => comment_id).delete_all
    vote = self.create(:user_id => user_id, :comment_id => comment_id, :vote_type => vote_type)
    comment.update_counters
    comment
  end
end
