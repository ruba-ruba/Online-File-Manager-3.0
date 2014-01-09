class VotesController < ApplicationController
  def vote
    vote_type = params[:vote_type].to_s
    @comment = Comment.find params[:comment_id]
    @vote = Vote.find_or_create_by_user_id_and_comment_id(current_user.id, @comment.id, vote_type: params[:vote_type])
    @vote.update_attribute(:vote_type, params[:vote_type]) unless vote_type == @vote.vote_type
    @vote.comment.update_counters
    respond_to { |f| f.js }
  end
end
