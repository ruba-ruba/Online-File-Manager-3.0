require 'spec_helper'

describe "Users", :type => :feature do
  describe "GET /users" do
    xit "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get users_path
      response.status.should be(200)
    end
  end
end
