require 'spec_helper'

describe Folder do
  
  describe "#size" do
    let(:folder){FactoryGirl.create(:folder)}
    it "should return size" do
      expect(folder.size).to eq(0)
    end
  end
  describe "#zip_archive" do
    let(:folder){FactoryGirl.create(:folder_with_title)}
    let(:user){FactoryGirl.create(:user)}

    it "should return url" do
      expect(folder.zip_archive(user.id)).not_to be_nil
    end

    it "should return true url" do
      fake_file = stub(:url => 'resulting_url')
      fake_item = stub(:file =>fake_file)
      fake_zip = stub(:close => true)

      folder.expects(:add_to_zip).returns(true)
      Zip::File.expects(:open).returns(fake_zip)
      File.expects(:new).returns('file_with_data')
      File.expects(:delete).returns(true)
      Item.expects(:create).with(folder_id: nil, user_id: user.id, file: 'file_with_data').returns  (fake_item)

      expect(folder.zip_archive(user.id)).to eq('resulting_url')
    end

    it "#add_to_zip" do
      fake_zip = stub(:close => true, :mkdir => true)
      fake_item = stub(:each => true)

      Zip::File.expects(:open).returns(fake_zip)
      folder.expects(:has_children?).returns(false)
      folder.expects(:items).returns(fake_item)

      folder.add_to_zip("mnt/jhdf.zip")
    end
  end
end
