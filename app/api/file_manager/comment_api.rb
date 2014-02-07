require 'grape'

module FileManager
  module CommentAPI
    def self.included(base)

      base.resource :comments do
        get do
          present commentable.comments, with: CommentEntity
        end
        post do
          comment = commentable.comments.build(user_id: current_user.id, content: params[:content], parent_id: params[:parent_id])
          if comment.save
           present comment, with: CommentEntity
          else
            error!("can't save comment")
          end
        end

        resource ":comment_id" do
          get do
            present commentable.comments.find(params[:comment_id]), with: CommentEntity
          end
          delete do
            commentable.comments.find(params[:comment_id]).destroy
          end

          resource :vote do
            post do
              comment = Vote.revote(params[:vote_type], params[:comment_id], current_user.id)
              present comment, with: CommentEntity
            end
          end
        end
      end
    end
  end
end