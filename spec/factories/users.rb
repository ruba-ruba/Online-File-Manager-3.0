# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email "user#{Random.rand(1000)}@example.com"
    password "my_pass"
    role "user"
  end
end
