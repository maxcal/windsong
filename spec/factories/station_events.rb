# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :station_event, :class => 'Station::Event' do
    key :offline
  end
end
