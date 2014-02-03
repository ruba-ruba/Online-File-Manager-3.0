require 'grape-entity'

module FileManager
  class VoteEntity < Grape::Entity
    extend ActionView::Helpers
    expose :comment_id
    expose :user_id
    expose :vote_type
    expose :vote_up_path
    expose :vote_down_path
  end
end