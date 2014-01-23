FactoryGirl.define do
  factory :folder do
    title {generate(:folder)}
  end

  factory :folder_with_title, :class => 'Folder' do
    title "video"
  end

  factory :folder_with_user, :class => 'Folder' do
    title {generate(:folder)}
    association :user
  end

end
