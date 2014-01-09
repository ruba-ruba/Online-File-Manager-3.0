require "spec_helper"

describe CommentsController do
  describe "routing" do

    it "routes to #index" do
      get("folders/1/comments").should route_to("comments#index", "folder_id"=>"1")
    end

    it "routes to #new" do
      get("folders/1/comments/new").should route_to("comments#new", "folder_id"=>"1")
    end

    it "routes to #create" do
      post("folders/1/comments").should route_to("comments#create", "folder_id"=>"1")
    end

    it "routes to #destroy" do
      delete("folders/1/comments/1").should route_to("comments#destroy", "folder_id"=>"1", "id" => "1")
    end

  end
end
