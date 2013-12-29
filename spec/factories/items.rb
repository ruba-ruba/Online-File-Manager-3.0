FactoryGirl.define do
  factory :item do
    association :user, :factory => :user
    association :folder, :factory => :folder
    file_file_name {generate(:item_name)}
    file_content_type "application/x-msdownload"
    file_file_size "7766"
    file_updated_at "#{Time.now}"
  end
end