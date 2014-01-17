require 'spec_helper'

describe DuplicatesController do
  login_user

  describe "GET index" do
    it "assigns all Item.duplicates as @items" do
      get :index
      response.should be_success
    end
  end
end
