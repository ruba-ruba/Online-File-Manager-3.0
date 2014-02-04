require 'spec_helper'

describe FileManager::API do

  let(:user){FactoryGirl.create :user}

  describe "GET /api/v3/items" do
    it "returns an empty array of items" do
      get "/api/v3/items?token=#{user.token}"
      response.status.should == 200
      JSON.parse(response.body).should == []
    end
  end

  describe "GET /api/v3/folders/:id/items" do
    let!(:folder){FactoryGirl.create :folder}
    let!(:item){FactoryGirl.create(:item, :file_file_name => 'book.txt', :folder_id => folder.id)}
    it "returns a folder with id and some item" do
      get "/api/v3/folders/#{folder.id}/items"
      response.status.should == 200
      response_hash = JSON.parse(response.body)[0]
      expect(response_hash["file_file_name"]).to eq("book.txt")
    end
  end

  describe "GET /api/v3/folders/:id/items" do
    let!(:folder){FactoryGirl.create :folder}
    let!(:item){FactoryGirl.create(:item, :description => 'here is my item', :folder_id => folder.id)}
    it "returns a folder with id, item with description" do
      get "/api/v3/folders/#{folder.id}/items"
      response.status.should == 200
      response_hash = JSON.parse(response.body)[0]
      expect(response_hash["description"]).to eq("here is my item")
    end
  end

  describe "GET /api/v3/folders/:id/items" do
    let!(:folder){FactoryGirl.create :folder}
    let!(:item){FactoryGirl.create(:item, :file_file_size => '25', :folder_id => folder.id)}
    it "returns a folder with id, item with size" do
      get "/api/v3/folders/#{folder.id}/items"
      response.status.should == 200
      response_hash = JSON.parse(response.body)[0]
      expect(response_hash["size"]).to eq("25 Bytes")
    end
  end

  describe "GET /api/v3/folders/:id/items" do
    let!(:folder){FactoryGirl.create :folder}
    let!(:item){FactoryGirl.create(:item, :file_content_type => "application/x-msdownload", :folder_id => folder.id)}
    it "returns a folder with id, item with file_content_type" do
      get "/api/v3/folders/#{folder.id}/items"
      response.status.should == 200
      response_hash = JSON.parse(response.body)[0]
      expect(response_hash["file_content_type"]).to eq("application/x-msdownload")
    end
  end

  describe "GET /api/v3/folders/:id/items" do
    let!(:folder){FactoryGirl.create :folder}
    let!(:item){FactoryGirl.create(:item, :folder_id => folder.id)}
    it "returns a folder with id, item with date of updation" do
      get "/api/v3/folders/#{folder.id}/items"
      response.status.should == 200
      response_hash = JSON.parse(response.body)[0]
      expect(response_hash["file_updated_at"]).to eq(item.updated_at.strftime('%d/%m/%y %I:%M%p'))
    end
  end

  describe "GET /api/v3/folders/:id/items" do
    let!(:folder){FactoryGirl.create :folder}
    let!(:item){FactoryGirl.create(:item, :file_file_name => 'photo.jpg', :folder_id => folder.id)}
    it "returns a folder with id, item with some extension" do
      get "/api/v3/folders/#{folder.id}/items"
      response.status.should == 200
      response_hash = JSON.parse(response.body)[0]
      expect(response_hash["extension"]).to eq(item.updated_at.strftime('jpg'))
    end
  end

  describe "GET /api/v3/folders/:id/items" do
    let!(:folder){FactoryGirl.create :folder}
    let!(:item){FactoryGirl.create(:item, :file_file_name => 'photo.jpg', :folder_id => folder.id)}
    it "returns a folder with id, item mp3 false" do
      get "/api/v3/folders/#{folder.id}/items"
      response.status.should == 200
      response_hash = JSON.parse(response.body)[0]
      expect(response_hash["mp3?"]).to eq(false)
    end
  end

  describe "GET /api/v3/folders/:id/items" do
    let!(:folder){FactoryGirl.create :folder}
    let!(:item){FactoryGirl.create(:item, :file_file_name => 'music.mp3', :folder_id => folder.id)}
    it "returns a folder with id, item mp3 true" do
      get "/api/v3/folders/#{folder.id}/items"
      response.status.should == 200
      response_hash = JSON.parse(response.body)[0]
      expect(response_hash["mp3?"]).to eq(true)
    end
  end

  describe "GET /api/v3/folders/:id/items" do
    let!(:folder){FactoryGirl.create :folder}
    let!(:item){FactoryGirl.create(:item, :file_content_type => '', :folder_id => folder.id)}
    it "returns a folder with id, item with icon 'page'" do
      get "/api/v3/folders/#{folder.id}/items"
      response.status.should == 200
      response_hash = JSON.parse(response.body)[0]
      expect(response_hash["content_icon"]).to eq("<img align='bottom' border='0'class='icon' src='/assets/icons/fam-fam/16/page.png' />")
    end
  end

  describe "GET /api/v3/folders/:id/items" do
    let!(:folder){FactoryGirl.create :folder}
    let!(:item){FactoryGirl.create(:item, :file_content_type => 'application/vnd.ms-excel', :folder_id => folder.id)}
    it "returns a folder with id, item with icon 'map'" do
      get "/api/v3/folders/#{folder.id}/items"
      response.status.should == 200
      response_hash = JSON.parse(response.body)[0]
      expect(response_hash["content_icon"]).to eq("<img align='bottom' border='0'class='icon' src='/assets/icons/fam-fam/16/map.png' />")
    end
  end

  describe "GET /api/v3/folders/:id/items" do
    let!(:folder){FactoryGirl.create :folder}
    let!(:item){FactoryGirl.create(:item, 
      :file_content_type => 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 
      :folder_id => folder.id)}
    it "returns a folder with id, item with icon 'page_excel'" do
      get "/api/v3/folders/#{folder.id}/items"
      response.status.should == 200
      response_hash = JSON.parse(response.body)[0]
      expect(response_hash["content_icon"]).to eq("<img align='bottom' border='0'class='icon' src='/assets/icons/fam-fam/16/page_excel.png' />")
    end
  end

  describe "GET /api/v3/folders/:id/items" do
    let!(:folder){FactoryGirl.create :folder}
    let!(:item){FactoryGirl.create(:item, 
      :file_content_type => 'application/pdf', 
      :folder_id => folder.id)}
    it "returns a folder with id, item with icon 'page_white_acrobat'" do
      get "/api/v3/folders/#{folder.id}/items"
      response.status.should == 200
      response_hash = JSON.parse(response.body)[0]
      expect(response_hash["content_icon"]).to eq("<img align='bottom' border='0'class='icon' src='/assets/icons/fam-fam/16/page_white_acrobat.png' />")
    end
  end

  describe "GET /api/v3/folders/:id/items" do
    let!(:folder){FactoryGirl.create :folder}
    let!(:item){FactoryGirl.create(:item, 
      :file_content_type => 'mp3', 
      :folder_id => folder.id)}
    it "returns a folder with id, item with icon 'music'" do
      get "/api/v3/folders/#{folder.id}/items"
      response.status.should == 200
      response_hash = JSON.parse(response.body)[0]
      expect(response_hash["content_icon"]).to eq("<img align='bottom' border='0'class='icon' src='/assets/icons/fam-fam/16/music.png' />")
    end
  end

  describe "GET /api/v3/folders/:id/items" do
    let!(:folder){FactoryGirl.create :folder}
    let!(:item){FactoryGirl.create(:item, 
      :file_content_type => 'wav', 
      :folder_id => folder.id)}
    it "returns a folder with id, item with icon 'music'" do
      get "/api/v3/folders/#{folder.id}/items"
      response.status.should == 200
      response_hash = JSON.parse(response.body)[0]
      expect(response_hash["content_icon"]).to eq("<img align='bottom' border='0'class='icon' src='/assets/icons/fam-fam/16/music.png' />")
    end
  end

  describe "GET /api/v3/folders/:id/items" do
    let!(:folder){FactoryGirl.create :folder}
    let!(:item){FactoryGirl.create(:item, 
      :file_content_type => 'octet-stream', 
      :folder_id => folder.id)}
    it "returns a folder with id, item with icon 'music'" do
      get "/api/v3/folders/#{folder.id}/items"
      response.status.should == 200
      response_hash = JSON.parse(response.body)[0]
      expect(response_hash["content_icon"]).to eq("<img align='bottom' border='0'class='icon' src='/assets/icons/fam-fam/16/music.png' />")
    end
  end

  describe "GET /api/v3/folders/:id/items" do
    let!(:folder){FactoryGirl.create :folder}
    let!(:item){FactoryGirl.create(:item, 
      :file_content_type => 'jpeg', 
      :folder_id => folder.id)}
    it "returns a folder with id, item with icon 'picture'" do
      get "/api/v3/folders/#{folder.id}/items"
      response.status.should == 200
      response_hash = JSON.parse(response.body)[0]
      expect(response_hash["content_icon"]).to eq("<img align='bottom' border='0'class='icon' src='/assets/icons/fam-fam/16/picture.png' />")
    end
  end

  describe "GET /api/v3/folders/:id/items" do
    let!(:folder){FactoryGirl.create :folder}
    let!(:item){FactoryGirl.create(:item, 
      :file_content_type => 'png', 
      :folder_id => folder.id)}
    it "returns a folder with id, item with icon 'picture'" do
      get "/api/v3/folders/#{folder.id}/items"
      response.status.should == 200
      response_hash = JSON.parse(response.body)[0]
      expect(response_hash["content_icon"]).to eq("<img align='bottom' border='0'class='icon' src='/assets/icons/fam-fam/16/picture.png' />")
    end
  end
end
