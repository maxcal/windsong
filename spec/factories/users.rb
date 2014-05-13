# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    username "joe.bloggs"
    email "test@example.com"
    password "abcd1234"
    password_confirmation "abcd1234"
  end
end
