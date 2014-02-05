require 'grape'

module FileManager
  class CommentAPI < Grape::API
    helpers do
      def commentable
        @commentable ||= Folder.find(params[:folder_id]) if params[:folder_id]
        @commentable ||= Item.find(params[:item_id]) if params[:item_id]
        @commentable
      end
    end
    resource :comments do
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
          present commentable.comments.find (params[:comment_id]), with: CommentEntity
        end
      end
    end
  end
end