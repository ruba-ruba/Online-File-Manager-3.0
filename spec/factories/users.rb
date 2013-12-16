# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email {generate(:user_email)}
    password "my_pass"
    role "user"
  end
end
