class UsersController < ApplicationController
  include UsersHelper
  before_filter :authenticate_user!, except: :show_user_info
  before_filter :check_if_admin, only: [:destroy]
  before_filter :correct_user, only: :show

  def index
    @users = User.all

    respond_to do |format|
      format.html 
      format.json { render json: @users }
    end
  end

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end
    
  def destroy
    user = User.find(params[:id])
    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end

  def show_user_info
    user = User.find_by_token params[:token]
    render json: user.as_api
  end

  protected

  def check_if_admin
    unless admin?
      redirect_to root_path
      flash[:error] = "you are not allowed to this action"
    end
  end

  def correct_user
    user = User.find(params[:id])
    unless admin? || current_user == user  
      redirect_to root_path
      flash[:error] = "you are not allowed to this action"
    end
  end
end
