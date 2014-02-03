require 'spec_helper'

describe UsersController do

  login_user

  describe "GET index" do
    it "assigns all users as @users" do
      # user = FactoryGirl.create(:user)
      get :index
      assigns(:users).should eq([@current_user])
    end
  end

  describe "GET show" do
    it "assigns the requested user as @user" do
      user = FactoryGirl.create(:user)
      get :show, {:id => @current_user.id}
      assigns(:user).should eq(@current_user)
    end
  end

  describe "PUT update" do
    describe "with valid params" do

      it "assigns the requested user as @user" do
        user = FactoryGirl.create(:user)
        put :update, {:id => user.to_param, :user => FactoryGirl.build(:user)}
        assigns(:user).should eq(user)
      end

      it "redirects to the user" do
        user = FactoryGirl.create(:user)
        put :update, {:id => user.to_param, :user => FactoryGirl.build(:user)}
        response.should redirect_to users_path
      end
    end

    describe "with invalid params" do
      it "assigns the user as @user" do
        user = FactoryGirl.create(:user)
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stubs(:save).returns(false)
        put :update, {:id => user.to_param, :user => {  }}
        assigns(:user).should eq(user)
      end

      it "re-renders the 'edit' template" do
        user = FactoryGirl.create(:user)
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stubs(:save).returns(false)
        put :update, {:id => user.to_param, :user => {  }}
        response.should redirect_to users_path
      end
    end
  end

  describe "DELETE destroy" do
    login_admin
    it "destroys the requested user" do
      user = FactoryGirl.create(:user)
      expect {
        delete :destroy, {:id => user.to_param}
      }.to change(User, :count).by(-1)
    end

    it "redirects to the users list" do
      user = FactoryGirl.create(:user)
      delete :destroy, {:id => user.to_param}
      response.should redirect_to(users_url)
    end
  end

end
