require 'spec_helper'

describe "Folders" do

  login_user
  
  let(:folder){FactoryGirl.create(:folder)}

  describe "Index page" do
    xit "should have the content 'Listing folders'" do
      visit '/folders'
      page.should have_content('Listing folders')
    end
  end

  describe "Edit page" do
    xit "should have the content 'Editing folder'" do
      visit edit_folder_path(folder)
      page.should have_content('Editing folder')
    end
  end

  describe "New page" do
    xit "should have the content 'New folder'" do
      visit '/folders/new'
      page.should have_content('New folder')
    end
  end

  describe "Show page" do
    xit "should have the content 'Title'" do
      visit folder_path(folder)
      page.should have_content('Title')
    end
  end
end
