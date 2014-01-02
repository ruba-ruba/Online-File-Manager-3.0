class CommentsController < ApplicationController

  before_filter  :load_commentable
  before_filter  :authenticate_user!, :except => [:index, :show]
  before_filter  :find_comment_and_check_manageability, :only => [:destroy]
  
  def index
    @comments = @commentable.comments.order(:created_at).page(params[:page]).per(5)
  end

  def new
    @comment = @commentable.comments.new(:user_id => current_user.id, :parent_id => params[:comment_id])
  end

  def create
    @comment = @commentable.comments.build(params[:comment].merge({:user_id => current_user.id}))
    if @comment.save
      redirect_to [@commentable, :comments]
    else
      render :action => 'new'
    end
  end

  def destroy
    @comment.destroy
    redirect_to :back
  end

  private

    def find_comment_and_check_manageability
      @comment = Comment.find(params[:id])
      unless current_user.can_manage?(@comment)
        flash[:error] = "you can not do that"
        redirect_to :back and return  
      end
    end

    def load_commentable
      resource, id = request.path.split('/')[1, 2]
      @commentable = resource.singularize.classify.constantize.find(id)
    end
end
