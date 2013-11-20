require "spec_helper"

describe FoldersController do
  describe "routing" do

    it "routes to #index" do
      get("/folders").should route_to("folders#index")
    end

    it "routes to #new" do
      get("/folders/new").should route_to("folders#new")
    end

    it "routes to #show" do
      get("/folders/1").should route_to("folders#show", :id => "1")
    end

    it "routes to #edit" do
      get("/folders/1/edit").should route_to("folders#edit", :id => "1")
    end

    it "routes to #create" do
      post("/folders").should route_to("folders#create")
    end

    it "routes to #update" do
      put("/folders/1").should route_to("folders#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/folders/1").should route_to("folders#destroy", :id => "1")
    end

  end
end
