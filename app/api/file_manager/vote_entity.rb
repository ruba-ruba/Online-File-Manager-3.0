require 'grape-entity'

module FileManager
  class VoteEntity < Grape::Entity
    extend ActionView::Helpers
    expose :id
    expose :vote_type
    expose :user_id
    expose :comment_id
  end
end