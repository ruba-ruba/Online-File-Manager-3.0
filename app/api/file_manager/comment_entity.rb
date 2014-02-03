require 'grape-entity'

module FileManager
  class CommentEntity < Grape::Entity
    extend ActionView::Helpers
    expose :id
    expose :votes_up
    expose :votes_down
    expose :user_id
    expose :content
    expose :created_date_time do |comment, options|
      comment.created_at.strftime("%b %e, %l:%M %p")
    end
    expose :author do |comment, options|
      comment.author
    end
    expose :parent_identifier do |comment, options|
      comment.parent ? ".comment-#{comment.parent.id}" : '.comments>ul'
    end
  end
end