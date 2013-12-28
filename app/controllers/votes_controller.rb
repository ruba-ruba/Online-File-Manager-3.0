class VotesController < ApplicationController
  def vote
    vote_type = eval(params[:vote_type])
    @vote = Vote.find_by_user_id_and_comment_id(current_user.id, params[:comment])
    respond_to do |format|
      if @vote.present? && vote_type == @vote.vote_type
        format.js
      elsif @vote.present? && vote_type != @vote.vote_type
        #update vote +/- and update true/false
        @vote.update_attribute(:vote_type, vote_type)
        if vote_type
          @vote.comment.vote_change('votes_up', 'votes_down')
        else
          @vote.comment.vote_change('votes_down', 'votes_up')
        end
        format.js
      else
        @vote = Vote.create(user_id: current_user.id, comment_id: params[:comment], vote_type: vote_type)
        vote_type ? @vote.comment.vote_up('votes_up') : @vote.comment.vote_up('votes_down')
        format.js
      end
    end
  end

end
