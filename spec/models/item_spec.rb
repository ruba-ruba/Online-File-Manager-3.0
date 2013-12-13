require 'spec_helper'

describe Item do
  
  describe 'methods' do
    it 'should return right name' do
      binding.pry
      url1 = FactoryGirl.create(:item, file_file_name: 'http://railsforum.com')
      url2 = FactoryGirl.create(:item, file_file_name: 'http://railsforum.com/')
      url3 = FactoryGirl.create(:item, file_file_name: 'http://railsforum.com/some_path')
      url4 = FactoryGirl.create(:item, file_file_name: 'http://railsforum.com/some_path.png')

      Item.file_name(url1, host1).should eq("httprailsforum.com.html")
      Item.file_name(url2, host2).should eq("httprailsforum.com.html")
      Item.file_name(url3, host3).should eq("httprailsforum.comsome_path.html")
      Item.file_name(url4, host4).should eq("httprailsforum.comsome_path.png")
    end
  end

end
