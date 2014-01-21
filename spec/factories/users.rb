# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :user do
    email {generate(:user_email)}
    password "my_pass"
    role "user"
    token SecureRandom.hex
  end

  factory :admin, :parent => :user do
    after(:create) do |user|
      user.update_attribute(:role, 'admin')
    end
  end

  factory :user_wiht_token, :parent => :user do
    after(:create) do |user|
      user.update_attribute(:token, 'baM80EgOTSifODeo8TxgyA')
    end
  end

  factory :user_wiht_expires, :parent => :user do
    after(:create) do |user|
      user.update_attribute(:expires_at, DateTime.now-400)
    end
  end
end