require "spec_helper"

describe DuplicatesController do
  describe "routing" do

    it "routes to #index" do
      get("/duplicates").should route_to("duplicates#index")
    end

    it "routes to #new" do
      get("/duplicates/new").should route_to("duplicates#new")
    end

    it "routes to #show" do
      get("/duplicates/1").should route_to("duplicates#show", :id => "1")
    end

    it "routes to #edit" do
      get("/duplicates/1/edit").should route_to("duplicates#edit", :id => "1")
    end

    it "routes to #create" do
      post("/duplicates").should route_to("duplicates#create")
    end

    it "routes to #update" do
      put("/duplicates/1").should route_to("duplicates#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/duplicates/1").should route_to("duplicates#destroy", :id => "1")
    end

  end
end
