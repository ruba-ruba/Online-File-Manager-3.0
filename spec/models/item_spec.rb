require 'spec_helper'

describe Item do

  let(:item_with_file_true) { FactoryGirl.create(:item, :file => fixture_file_upload('/test.txt', 'text.html'))}
  let(:item_with_file_false) { FactoryGirl.create(:item, :file => fixture_file_upload('/test.jpg')) }

  describe 'parse_map' do
    it 'should parse_map' do 
      expect{ FactoryGirl.create(:item, :file => fixture_file_upload('/map.csv')) }.to change(Location, :count).by(1)
    end
  end

  describe 'txt_or_html' do
    it 'should find file' do 
      expect(item_with_file_true.txt_or_html?).to eq(true)
    end
    it 'should find file' do 
      expect(item_with_file_false.txt_or_html?).to eq(false)
    end
  end

  describe "is_mp3" do
    let(:item_with_file_true) { FactoryGirl.create(:item, :file => fixture_file_upload('/test.mp3'))}
    it 'should find file' do
      expect(item_with_file_true.is_mp3?).to eq(true)
    end
  end

  describe 'self.duplicates' do
    let!(:item1){FactoryGirl.create(:item, :file_file_name => '1.txt', :file_file_size => "10",:folder => FactoryGirl.create(:folder))}
    let!(:item2){FactoryGirl.create(:item, :file_file_name => '1.txt', :file_file_size => "10",:folder => FactoryGirl.create(:folder))}
    let!(:item3){FactoryGirl.create(:item, :file_file_name => '2.txt', :file_file_size => "10",:folder => FactoryGirl.create(:folder))}
    let!(:item4){FactoryGirl.create(:item, :file_file_name => '2.txt', :file_file_size => "11",:folder => FactoryGirl.create(:folder))}
    let!(:item5){FactoryGirl.create(:item, :file_file_name => '3.txt', :file_file_size => "11",:folder => FactoryGirl.create(:folder))}
    let!(:item6){FactoryGirl.create(:item, :file_file_name => '4.txt', :file_file_size => "11",:folder => FactoryGirl.create(:folder))}
    let!(:item7){FactoryGirl.create(:item, :file_file_name => '5.txt', :file_file_size => "12",:folder => FactoryGirl.create(:folder))}
    let!(:item8){FactoryGirl.create(:item, :file_file_name => '6.txt', :file_file_size => "13",:folder => FactoryGirl.create(:folder))}
    let!(:item9){FactoryGirl.create(:item, :file_file_name => '7.txt', :file_file_size => "12",:folder => FactoryGirl.create(:folder))}
    let!(:item10){FactoryGirl.create(:item, :file_file_name => '7.txt', :file_file_size => "12",:folder => FactoryGirl.create(:folder))}
    it 'should find duplicates' do
      expect(Item.duplicates).to eq([item1, item2, item9, item10])
    end
  end

  describe 'self.statistics' do
    let!(:item1){FactoryGirl.create(:item, :file_file_name => 'text.txt', :file_file_size => "10", :file_content_type => "text/plain")}
    let!(:item2){FactoryGirl.create(:item, :file_file_name => 'music.mp3', :file_file_size => "12", :file_content_type => "audio/mp3")}
    let!(:item3){FactoryGirl.create(:item, :file_file_name => '123.pdf', :file_file_size => "3", :file_content_type => "application/pdf")}
    let!(:item4){FactoryGirl.create(:item, :file_file_name => 'photo.jpg', :file_file_size => "20", :file_content_type => "image/jpeg")}
    let!(:item5){FactoryGirl.create(:item, :file_file_name => 'video.wmv', :file_file_size => "100", :file_content_type => "video/x-ms-wmv")}
    let!(:item6){FactoryGirl.create(:item, :file => fixture_file_upload('/map.csv'))}

    it 'should show statistics' do
      data = Item.statistics
      expect(data[:total_count]).to eq(6)
      expect(data[:total_sum]).to eq(165)
      expect(data[:images_sum]).to eq(20)
      expect(data[:images_count]).to eq(1)
      expect(data[:video_sum]).to eq(100)
      expect(data[:video_count]).to eq(1)
      expect(data[:music_sum]).to eq(12)
      expect(data[:music_count]).to eq(1)
      expect(data[:texts_sum]).to eq(13)
      expect(data[:texts_count]).to eq(2)
      expect(data[:maps_sum]).to eq(20)
      expect(data[:maps_count]).to eq(1)
    end
  end
  
  describe 'methods' do
    it 'should return right name' do
      host = 'railsforum.com'
      url1 = 'http://railsforum.com'
      url2 = 'http://railsforum.com/'
      url3 = 'http://railsforum.com/some_path'
      url4 = 'http://railsforum.com/some_path.png'

      Item.file_name(url1, host).should eq("index.html")
      Item.file_name(url2, host).should eq("index.html")
      Item.file_name(url3, host).should eq("some_path")
      Item.file_name(url4, host).should eq("some_path.png")
    end

    it 'should return file extension' do
      file1 = FactoryGirl.create(:item, file_file_name: 'new1.txt')
      file2 = FactoryGirl.create(:item, file_file_name: 'new2.Txt')
      file3 = FactoryGirl.create(:item, file_file_name: 'new3.mp3.TXT')
      file4 = FactoryGirl.create(:item, file_file_name: 'SOMEfile')

      file1.extension.should eq('txt')
      file2.extension.should eq('txt')
      file3.extension.should eq('txt')
      file4.extension.should eq('')
    end
  end

end
