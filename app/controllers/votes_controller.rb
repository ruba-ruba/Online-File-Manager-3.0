class VotesController < ApplicationController
  def vote
    vote = Vote.new(user_id: current_user.id, comment_id: params[:comment])
    respond_to do |format|
      if vote.save
        update_votes_couter
        format.js
      else
        format.js
      end
    end
  end

  def update_votes_couter
    comment = Comment.find params[:comment]
    if params[:vote] == 'up'
      updated = comment.votes_up ? comment.votes_up + 1 : 1 
      comment.update_attribute(:votes_up, updated)
    else
      updated = comment.votes_up ? comment.votes_up + 1 : 1
      comment.update_attribute(:votes_down, updated)
    end
  end

end
