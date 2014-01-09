FactoryGirl.define do

  factory :folder_comment, :class => 'Comment' do
    content "comment for something"
    association :commentable, :factory => :folder
  end

  factory :folder_comment_with_votes, :class => 'Comment', :parent => :folder_comment do |l|
    association :user
    ignore do
      negative_votes 5
      positive_votes 3
    end
    after(:create) do |comment, data|
      create_list(:vote, data.negative_votes, :comment => comment, :vote_type => false)
      create_list(:vote, data.positive_votes, :comment => comment, :vote_type => true)
    end
  end

  factory :item_comment, :class => 'Comment' do 
    content "comment for something"
    association :commentable, :factory => :item
  end
end
