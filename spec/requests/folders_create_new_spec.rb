require 'spec_helper'

describe "Folders" do

  login_user

  it "creates new folder" do
    visit '/folders/new'
    fill_in "Title", :with => "some_titile"
    fill_in "Description", :with => "some_description"
    click_button "Save"
    page.should have_content("Folder was successfully created")
    Folder.find_by_title("some_titile").should be_present
  end

  it "has title" do
    expect {
      visit '/folders/new'
      fill_in "Title", :with => ""
      fill_in "Description", :with => "some_description"
      click_button "Save"
      page.should have_content("Title can't be blank")
    }.to change(Folder, :count).by(0)

  end

  it "has unique title" do
    expect {
      visit '/folders/new'
      fill_in "Title", :with => "some_titile"
      fill_in "Description", :with => "some_description"
      click_button "Save"
      page.should have_content("Folder was successfully created")
      Folder.find_by_title("some_titile").should be_present
    }.to change(Folder, :count).by(1)
    expect {
      visit '/folders/new'
      fill_in "Title", :with => "some_titile"
      fill_in "Description", :with => "some_description"
      click_button "Save"
      page.should have_content("Title has already been taken")      
    }.to change(Folder, :count).by(0)
  end
end
