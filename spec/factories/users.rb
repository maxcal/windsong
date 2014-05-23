FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| n == 1 ? "joe.bloggs" : "joe.bloggs-#{n}" }
    sequence(:email) { |n| n == 1 ? "test@example.com" : "test#{n}@example.com" }
    password "abcd1234"
    password_confirmation "abcd1234"
    confirmed_at Time.now
  end
end
