require 'grape-entity'

module FileManager
  class CommentEntity < Grape::Entity
    extend ActionView::Helpers
    expose :id
    expose :votes_up
    expose :votes_down
    expose :user_id
    expose :parent_id
    expose :content
  end
end