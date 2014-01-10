class VotesController < ApplicationController
  def vote
    @comment, @vote = Vote.revote(params[:vote_type], params[:comment_id], current_user.id)
  end
end
