require "spec_helper"

describe DuplicatesController do
  describe "routing" do

    it "routes to #index" do
      get("/duplicates").should route_to("duplicates#index")
    end
  end
end
