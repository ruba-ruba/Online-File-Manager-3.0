require 'spec_helper'

describe SearchFilesController do

  render_views
  describe "Find existing files" do

    let!(:item1){FactoryGirl.create(:item, file_file_name: 'ololo.txt',:folder => FactoryGirl.create(:folder))}
    let!(:item2){FactoryGirl.create(:item, file_file_name: 'ttttt.txt',:folder => FactoryGirl.create(:folder))}
    it "returns http success and founed items" do
      get 'index', :q => {"file_file_name_cont" => "olo"}
      expect(assigns(:q).result).to eq([item1])
      response.body.should have_content("olo")
    end
  end

  describe "Find not existing files" do
    let!(:item1){FactoryGirl.create(:item, file_file_name: 'hello.txt',:folder => FactoryGirl.create(:folder))}
    let!(:item2){FactoryGirl.create(:item, file_file_name: 'world.txt',:folder => FactoryGirl.create(:folder))}
    it "returns message" do
      get 'index', :q => {"file_file_name_cont" => "morning"}
      expect(assigns(:q).result).to eq([])
      response.body.should have_content("There is no files matching your request")
    end
  end
end
