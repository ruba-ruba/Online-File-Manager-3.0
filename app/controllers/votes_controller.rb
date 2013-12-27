class VotesController < ApplicationController
  def vote
    @vote = Vote.find_by_user_id_and_comment_id_and_vote_type(current_user.id, params[:comment], params[:vote_type])
    respond_to do |format|
      if @vote.save
        params[:vote] == 'up' ? @vote.comment.vote_up : @vote.comment.vote_down
        format.js
      else
        format.js
      end
    end
  end

end
