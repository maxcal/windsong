# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :authentication do
    provider 'facebook'
    uid '1234567'
    token 'ABCDEF...' # OAuth 2.0 access_token, which you may wish to store
    expires_at Time.at(1321747205) # when the access token expires (it always will)
  end
end
