class VotesController < ApplicationController
  def vote
    @vote = Vote.new(user_id: current_user.id, comment_id: params[:comment])
        binding.pry
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
