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
    expose :strftime do |comment, options|
      comment.created_at.strftime("%b %e, %l:%M %p")
    end
    expose :author do |comment, options|
      comment.author
    end
    # expose :parent-identifier ......
  end
end