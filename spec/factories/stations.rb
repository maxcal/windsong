# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :station do
    sequence(:name){ |i| "Test Station #{i}" }
    sequence(:hardware_uid){ |i| "AA-BBBBBB-CCCCCC-#{i}" }
    online true
  end
end
