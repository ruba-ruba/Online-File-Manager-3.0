require 'spec_helper'

describe CommentsController do
  login_user

  let(:valid_attributes) { { "content" => "MyText" } }

  let(:valid_session) { {} }

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
      expect{post :create, comment: FactoryGirl.attributes_for(:folder_comment), folder_id: folder.id}.to change(Comment,:count).by(1)
    end
    it 'should redirect to folder comments' do
      post :create, comment: FactoryGirl.attributes_for(:folder_comment), folder_id: folder.id
      expect(response).to redirect_to folder_comments_path(folder)
    end
    it 'should not create comment' do
      expect{post :create, comment: FactoryGirl.attributes_for(:folder_comment, content: nil), folder_id: folder.id}.to change(Comment,:count).by(0)
      response.should render_template :new
    end
  end

  describe "DELETE destroy" do
    let!(:user){FactoryGirl.create(:user)}
    let!(:comment){FactoryGirl.create(:folder_comment, user_id: user.id)}
    it "should delete comment" do
      request.env["HTTP_REFERER"] = 'where_i_came_from'
      expect{delete :destroy, id: comment, folder_id: comment.commentable.id}.to change(Comment,:count).by(-1) 
      response.should redirect_to 'where_i_came_from'
    end
  end

end
