require 'spec_helper'

describe FileManager::API do

  login_user

  describe "GET /api/v3/folders" do
    it "returns an empty array of folders" do
      get "/api/v3/folders"
      response.status.should == 200
      JSON.parse(response.body).should == []
    end
  end

  describe "GET /api/v3/folders/:id" do
    it "returns a folder with id" do
      folder = FactoryGirl.create :folder, :title => "First folder"
      folder2 = FactoryGirl.create :folder, :title => "Subfolder", :parent_id => folder.id
      get "/api/v3/folders/#{folder.id}"
      response.status.should == 200
      response_hash = JSON.parse(response.body)[0]
      expect(response_hash["title"]).to eq("Subfolder")
    end
  end
end
