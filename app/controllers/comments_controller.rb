class CommentsController < ApplicationController

   before_filter  :load_commentable
  
  def index
    @comments = @commentable.comments
  end

  def new
    @comment = @commentable.comments.new(:user_id => current_user.id, :parent_id => params[:comment_id])
  end

  def create
    @comment = @commentable.comments.build(params[:comment])
    if @comment.save
      redirect_to [@commentable, :comments]
    else
      render :action => 'new'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to :back
  end

  private

  def load_commentable
    resource, id = request.path.split('/')[1, 2]
    @commentable = resource.singularize.classify.constantize.find(id)
  end
end
