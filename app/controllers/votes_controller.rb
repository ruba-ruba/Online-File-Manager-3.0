class VotesController < ApplicationController
  def vote
    @comment = Vote.revote(params[:vote_type], params[:comment_id], current_user.id)
  end
end
