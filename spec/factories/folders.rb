# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :folder do
    title "MyString"
    description "MyString"
    user nil
  end
end
