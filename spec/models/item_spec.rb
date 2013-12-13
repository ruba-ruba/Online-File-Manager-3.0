require 'spec_helper'

describe Item do
  
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
  end

end
