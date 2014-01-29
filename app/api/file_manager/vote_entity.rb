require 'grape-entity'

module FileManager
  class VoteEntity < Grape::Entity
    extend ActionView::Helpers
    expose :comment_id
    expose :user_id
    expose :vote_type
    expose :vote_path_true do |vote, options|
      comment_id: vote.comment.id
      vote_type: true
    end
    expose :vote_path_false do |vote, options|
      comment_id: vote.comment.id
      vote_type: false
    end
  end
end