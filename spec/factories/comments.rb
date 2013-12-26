FactoryGirl.define do

  factory :folder_comment, :class => 'Comment' do
    content "comment for something"
    association :commentable, :factory => :folder
  end

  factory :item_comment, :class => 'Comment' do 
    content "comment for something"
    association :commentable, :factory => :item
  end
end