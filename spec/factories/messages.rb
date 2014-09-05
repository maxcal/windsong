# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    level :warning
    subject "Happy Birthday"
    body "Hello World!"
  end
end
