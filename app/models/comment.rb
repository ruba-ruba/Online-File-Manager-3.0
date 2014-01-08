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

  # move this method to helper or use gems drapper or decorator
  def status
    self.votes_up >= self.votes_down ? '' : 'negative'
  end

  def author
    user.name || "anonymous"
  end
end
