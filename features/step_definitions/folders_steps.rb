Given(/^I have folders titled Folder(\d+), Folder(\d+)$/) do |arg1, arg2|
  Folder.create(:title => 'Folder1')
  Folder.create(:title => 'Folder2')
end

When(/^I go to the list of folders$/) do
  folders_path
end

Then(/^I should see "(.*?)"$/) do |arg1|
  visit folders_path
end

Given(/^a user visits sing in page$/) do
  @user = User.create(name: "Example User", 
                    email: "user@example.com",
                    password: "foobar", 
                    password_confirmation: "foobar")
  visit users_path
  fill_in "Email",    with: @user.email
  fill_in "Password", with: @user.password
  click_button "Sign in"
end
  And(/^user visits the new folder page when he is logged in$/) do
    visit new_folder_path
  end

When(/^a user submits a valid information$/) do
  fill_in "Title", with: "some_titile"
  fill_in "Description", with: "some_description"
  click_button "Save"
end

Then(/^he should see a success message$/) do
  page.should have_content("Folder was successfully created")
end

  And(/^a new folder should be created$/) do
    Folder.find_by_title("some_titile").should be_present
  end

When(/^a user doesn't fill Title form$/) do
  fill_in "Title", :with => ""
  fill_in "Description", :with => "some_description"
  click_button "Save"
end

Then(/^he should see an error message about blank title$/) do
  page.should have_content("Title can't be blank")
end
  And(/^no new folder should be created$/) do
    change(Folder, :count).by(0)
  end

When(/^a user inputs the duplicate title$/) do
  fill_in "Title", :with => "some_titile"
  fill_in "Description", :with => "some_description"
  click_button "Save"
  page.should have_content("Folder was successfully created")
  Folder.find_by_title("some_titile").should be_present
  change(Folder, :count).by(1)
  visit '/folders/new'
  fill_in "Title", :with => "some_titile"
  fill_in "Description", :with => "some_description"
  click_button "Save"
end

Then(/^he should see an error message about duplicate title$/) do
  page.should have_content("Title has already been taken")
end