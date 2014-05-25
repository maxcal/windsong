FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| n == 1 ? "joe.bloggs" : "joe.bloggs-#{n}" }
    sequence(:email) { |n| n == 1 ? "test@example.com" : "test#{n}@example.com" }
    password "abcd1234"
    password_confirmation "abcd1234"
    confirmed_at Time.now
  end

  factory :admin, class: User  do
    sequence(:username) { |n| n == 1 ? "admin" : "admin-#{n}" }
    sequence(:email) { |n| n == 1 ? "admin@example.com" : "admin-#{n}@example.com" }
    password "abc123123"
    password_confirmation { "abc123123" }
    confirmed_at Time.now
    after(:create) do |user|
      user.add_role(:admin)
    end
  end

end
