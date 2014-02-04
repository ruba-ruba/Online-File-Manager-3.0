require 'spec_helper'

describe "Folders" do

  login_user
  
  let(:folder){FactoryGirl.create(:folder)}

  describe "Index page" do
    it "should have the content 'rOnline File manager 3.0'" do
      visit '/folders'
      page.should have_content('Online File manager 3.0')
    end
  end

  describe "New page" do
    it "should have the content 'New folder'" do
      visit '/folders/new'
      page.should have_content('New folder')
    end
  end

  describe "Show page" do
    it "should have the content 'title'" do
      visit folder_path(folder)
      page.should have_content('title')
    end
  end
end
