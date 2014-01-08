class VotesController < ApplicationController
  def vote
    vote_type = params[:vote_type].to_s
    @vote = Vote.find_or_create_by_user_id_and_comment_id(current_user.id, params[:comment_id], vote_type: params[:vote_type])
    respond_to do |format|
      if vote_type == @vote.vote_type
        @vote.comment.update_counters
        @comment = Comment.find params[:comment_id]
        format.js
      else
        @vote.update_attribute(:vote_type, params[:vote_type])
        @vote.comment.update_counters
        @comment = Comment.find params[:comment_id]
        format.js
      end
    end
  end

end
