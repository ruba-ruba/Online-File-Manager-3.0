require 'spec_helper'

describe CommentsController do
  login_user

  describe 'GET index' do 
    let!(:folder){FactoryGirl.create(:folder)}
    it 'should render comments for object' do
      get :index, folder_id: folder.id
      response.should be_success
      response.should render_template :index
    end
  end

  describe 'GET new' do
    let!(:folder){FactoryGirl.create(:folder)}
    it 'should render new for object' do
      get :new, folder_id: folder.id
      response.should be_success
      response.should render_template :new
    end
  end

  describe "POST create" do
    let!(:folder){FactoryGirl.create(:folder)}
    it 'should create comment' do
      mailer = stub(:deliver => true)
      FileManagerMailer.expects(:send_comment).returns(mailer)
      expect{
        post :create, comment: FactoryGirl.attributes_for(:folder_comment), folder_id: folder.id
      }.to change(Comment,:count).by(1)
    end
    it 'should redirect to folder comments' do
      mailer = stub(:deliver => true)
      FileManagerMailer.expects(:send_comment).returns(mailer)
      post :create, comment: FactoryGirl.attributes_for(:folder_comment), folder_id: folder.id
      expect(response).to be_success
    end
    it 'should not create comment' do
      request.env["HTTP_REFERER"] = 'where_i_came_from'
      expect{
        post :create, comment: FactoryGirl.attributes_for(:folder_comment, content: nil), folder_id: folder.id
      }.to change(Comment,:count).by(0)
      expect(flash).not_to be_nil
      expect(response).to be_success
    end
  end

  describe "DELETE destroy" do
    let!(:user){FactoryGirl.create(:user)}
    let!(:comment){FactoryGirl.create(:folder_comment, user_id: user.id)}
    it "should delete comment" do
      sign_in :user, user
      request.env["HTTP_REFERER"] = 'where_i_came_from'
      expect{
        delete :destroy, id: comment.id, folder_id: comment.commentable.id
      }.to change(Comment,:count).by(-1) 
      response.should redirect_to 'where_i_came_from'
    end

    it "should not delete comment" do
      request.env["HTTP_REFERER"] = 'where_i_came_from'
      expect{
        delete :destroy, id: comment.id, folder_id: comment.commentable.id
      }.to change(Comment,:count).by(0) 
      expect(flash).not_to be_nil
      expect(response).to redirect_to 'where_i_came_from'
    end
  end
end
