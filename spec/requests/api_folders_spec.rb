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
    it "returns a folder with id and some title" do
      folder = FactoryGirl.create :folder, :title => "First folder"
      folder2 = FactoryGirl.create :folder, :title => "Subfolder", :parent_id => folder.id
      get "/api/v3/folders/#{folder.id}"
      response.status.should == 200
      response_hash = JSON.parse(response.body)[0]
      expect(response_hash["title"]).to eq("Subfolder")
    end
  end

  describe "GET /api/v3/folders/:id" do
    it "returns a folder with id and some parent" do
      folder = FactoryGirl.create :folder, :title => "First folder"
      folder2 = FactoryGirl.create :folder, :title => "Subfolder", :parent_id => folder.id
      get "/api/v3/folders/#{folder.id}"
      response.status.should == 200
      response_hash = JSON.parse(response.body)[0]
      expect(response_hash["ancestry"]).to eq(folder.id.to_s)
    end
  end

  describe "GET /api/v3/folders" do
    it "returns a folder with description" do
      folder = FactoryGirl.create :folder, :description => "Super folder"
      get "/api/v3/folders"
      response.status.should == 200
      response_hash = JSON.parse(response.body)[0]
      expect(response_hash["description"]).to eq("Super folder")
    end
  end

  describe "GET /api/v3/folders" do
    let!(:folder){FactoryGirl.create :folder}
    let!(:item1){FactoryGirl.create(:item, :file_file_size => "10", :folder_id => folder.id)}
    let!(:item2){FactoryGirl.create(:item, :file_file_size => "25", :folder_id => folder.id)}
    it "returns a folder with size" do
      get "/api/v3/folders"
      response.status.should == 200
      response_hash = JSON.parse(response.body)[0]
      expect(response_hash["folder_size"]).to eq("35 Bytes")
    end
  end

  describe "GET /api/v3/folders" do
    let!(:folder){FactoryGirl.create :folder}
    it "returns a folder with date of updation" do
      get "/api/v3/folders"
      response.status.should == 200
      response_hash = JSON.parse(response.body)[0]
      expect(response_hash["updated_at"]).to eq(folder.updated_at.strftime('%d/%m/%y %I:%M%p'))
    end
  end

  describe "GET /api/v3/folders" do
    let!(:folder){FactoryGirl.create :folder}
    it "returns a folder with has_children? false" do
      get "/api/v3/folders"
      response.status.should == 200
      response_hash = JSON.parse(response.body)[0]
      expect(response_hash["has_children?"]).to eq(false)
    end
  end

  describe "GET /api/v3/folders" do    
    it "returns a folder with has_children? true" do
      folder = FactoryGirl.create :folder, :title => "Parent folder"
      folder2 = FactoryGirl.create :folder, :title => "Subfolder", :parent_id => folder.id
      get "/api/v3/folders"
      response.status.should == 200
      response_hash = JSON.parse(response.body)[0]
      expect(response_hash["has_children?"]).to eq(true)
    end
  end

  describe "GET /api/v3/folders" do  
    let!(:folder){FactoryGirl.create :folder}  
    it "returns a folder with tree_class 'glyphicon-plus'" do
      get "/api/v3/folders"
      response.status.should == 200
      response_hash = JSON.parse(response.body)[0]
      expect(response_hash["tree_class"]).to eq('glyphicon-plus')
    end
  end
end
