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
