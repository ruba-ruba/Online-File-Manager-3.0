require 'spec_helper'

describe FileManager::API do

  login_user

  describe "GET /api/v3/folders/id/comments" do
    it "returns an empty array of folders" do
      folder = FactoryGirl.create :folder
      get "/api/v3/folders/#{folder.id}/comments"
      response.status.should == 200
      JSON.parse(response.body).should == []
    end
  end

  describe "GET /api/v3/items/id/comments" do
    it "returns an empty array of items" do
      item = FactoryGirl.create :item
      get "/api/v3/items/#{item.id}/comments"
      response.status.should == 200
      JSON.parse(response.body).should == []
    end
  end

  describe "GET /api/v3/items/id/comments" do
    it "returns an id for items" do
      comment = FactoryGirl.create :item_comment, :user_id => @current_user.id   
      get "/api/v3/items/#{comment.commentable_id}/comments"
      response_hash = JSON.parse(response.body)[0]
      expect(response_hash["id"]).to eq(comment.commentable_id)
    end
  end

  describe "GET /api/v3/items/id/comments" do
    it "returns an user_id for items" do
      comment = FactoryGirl.create :item_comment, :user_id => @current_user.id   
      get "/api/v3/items/#{comment.commentable_id}/comments"
      response_hash = JSON.parse(response.body)[0]
      expect(response_hash["user_id"]).to eq(comment.user_id)
    end
  end

  describe "GET /api/v3/items/id/comments" do
    it "returns a content for items" do
      comment = FactoryGirl.create :item_comment, :user_id => @current_user.id, :content => "Hello"   
      get "/api/v3/items/#{comment.commentable_id}/comments"
      response_hash = JSON.parse(response.body)[0]
      expect(response_hash["content"]).to eq("Hello")
    end
  end

  describe "GET /api/v3/items/id/comments" do
    it "returns a votes_up for items" do
      comment = FactoryGirl.create :item_comment, :user_id => @current_user.id, :votes_up => 1   
      get "/api/v3/items/#{comment.commentable_id}/comments"
      response_hash = JSON.parse(response.body)[0]
      expect(response_hash["votes_up"]).to eq(comment.votes_up)
    end
  end

  describe "GET /api/v3/items/id/comments" do
    it "returns a votes_down for items" do
      comment = FactoryGirl.create :item_comment, :user_id => @current_user.id, :votes_down => 1   
      get "/api/v3/items/#{comment.commentable_id}/comments"
      response_hash = JSON.parse(response.body)[0]
      expect(response_hash["votes_down"]).to eq(comment.votes_down)
    end
  end

  describe "GET /api/v3/items/id/comments" do
    it "returns an author for items" do
      comment = FactoryGirl.create :item_comment, :user_id => @current_user.id  
      get "/api/v3/items/#{comment.commentable_id}/comments"
      response_hash = JSON.parse(response.body)[0]
      expect(response_hash["author"]).to eq("anonymous")
    end
  end

  describe "GET /api/v3/items/id/comments" do
    it "returns a no_parent_identifier for items" do
      comment = FactoryGirl.create :item_comment, :user_id => @current_user.id  
      get "/api/v3/items/#{comment.commentable_id}/comments"
      response_hash = JSON.parse(response.body)[0]
      expect(response_hash["parent_identifier"]).to eq(".comments>ul")
    end
  end

  describe "GET /api/v3/items/id/comments" do
    it "returns a parent_identifier for items" do
      comment = FactoryGirl.create :item_comment, :user_id => @current_user.id 
      comment = FactoryGirl.create :item_comment, :user_id => @current_user.id, :parent_id => comment.id  
      get "/api/v3/items/#{comment.commentable_id}/comments"
      response_hash = JSON.parse(response.body)[0]
      expect(response_hash["parent_identifier"]).to eq(".comment-#{comment.parent.id}")
    end
  end

  describe "GET /api/v3/items/id/comments" do
    it "returns a created_date_time for items" do
      comment = FactoryGirl.create :item_comment, :user_id => @current_user.id 
      get "/api/v3/items/#{comment.commentable_id}/comments"
      response_hash = JSON.parse(response.body)[0]
      expect(response_hash["created_date_time"]).to eq(comment.created_at.strftime("%b %e, %l:%M %p"))
    end
  end
end
