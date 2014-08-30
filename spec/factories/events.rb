# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    key :test_event
  end

  factory :station_event, class: Station::Event do
    key :test_event
  end
end
