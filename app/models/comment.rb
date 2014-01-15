class Comment < ActiveRecord::Base
  attr_accessible :commentable_id, :commentable_type, :content, :user_id, :parent_id, :votes_up, :votes_down

  has_ancestry

  belongs_to :commentable, :polymorphic => true
  belongs_to :user
  has_many :votes, :dependent => :destroy

  validates :content, presence: true

  def update_counters
    up = votes.where(:vote_type => true).count
    down = votes.where(:vote_type => false).count
    self.update_attributes(:votes_up => up, :votes_down => down)
  end

  def author
    user.name || "anonymous"
  end

  after_save do |comment|
    payload = comment.attributes
    Pusher["presence-" + comment.commentable_id.to_s].trigger('send_comment', payload)
  end
end
