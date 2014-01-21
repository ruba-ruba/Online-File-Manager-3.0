require 'spec_helper'

describe Admin::StatisticsController do
  render_views

  describe "Show statistic" do
    let!(:item1){FactoryGirl.create(:item, :file_file_name => 'hello.txt', :file_file_size => "10", :file_content_type => "text/plain")}
    let!(:item2){FactoryGirl.create(:item, :file_file_name => 'music.mp3', :file_file_size => "100", :file_content_type => "audio/mp3")}
    it "returns http success and statistic information" do
      get 'index'
      assigns(:data).should eq({"images_sum" => 0,
                               "images_count" => 0,
                               "video_sum" => 0,
                               "video_count" => 0,
                               "music_sum" => 100,
                               "music_count" => 1,
                               "texts_sum" => 10,
                               "texts_count" => 1,
                               "maps_sum" => 0,
                               "maps_count" => 0,
                               "total_count" => 2,
                               "total_sum" => 110})
      expect(response).to be_success
      expect(response.body).to have_content("Total amount of files in system", "total files sum", "total files count", "Text: 50 %", "Music: 50 %")
    end
  end

  describe "Show page with statistic when there is no any files in system" do
    login_user
    it "returns http success and no statistic information" do
      get "index"
      expect(response).to be_success
      expect(response.body).to have_content("Total amount of files in system:", "There are no files in system")
    end
  end
end
