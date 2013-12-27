class ChangeCommentVotesColumns < ActiveRecord::Migration
  def up
    change_column :comments, :votes_up, :integer, :default => 0
    change_column :comments, :votes_down, :integer, :default => 0

    Comment.all.each do |comment|
      comment.votes_up = 0 if comment.votes_up.nil?
      comment.votes_down = 0 if comment.votes_down.nil?
      comment.save(validate: false)
    end
  end
end
