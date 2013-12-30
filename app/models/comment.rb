class Comment < ActiveRecord::Base
  attr_accessible :commentable_id, :commentable_type, :content, :user_id, :parent_id

  has_ancestry
  
  belongs_to :commentable, :polymorphic => true
  belongs_to :user
  has_many :votes, :dependent => :destroy

  validates :content, presence: true

  def vote_up(col)
    updated = self.send(col.to_sym) ? self.send(col.to_sym) + 1 : 1 
    self.update_attribute(col.to_sym, updated)    
  end

  def vote_down(col) 
    updated = self.send(col.to_sym) != 0 ? self.send(col.to_sym) - 1 : 0
    self.update_attribute(col.to_sym, updated)
  end

  def vote_change(up_col, down_col)
    vote_up(up_col)
    vote_down(down_col)
  end

  def status
    self.votes_up >= self.votes_down ? '' : 'negative'
  end

  def author
    user.name || "anonymous"   
  end
end
