require 'spec_helper'

describe DuplicatesController do
  login_user
  render_views

  describe "GET index with duplicate files" do
    let!(:item1){FactoryGirl.create(:item, file_file_name: '1.txt',:folder => FactoryGirl.create(:folder))}
    let!(:item2){FactoryGirl.create(:item, file_file_name: '1.txt',:folder => FactoryGirl.create(:folder))}
    it "assigns all Item.duplicates as @items and find duplicates" do
      get :index
      response.should be_success
      response.body.should have_content("Item")
    end
  end

  describe "GET index without any duplicate files" do
    it "assigns all Item.duplicates as @items and cannot find any duplicates" do
      get :index
      response.should be_success
      response.body.should have_content("There are no duplicate files")
    end
  end
end
