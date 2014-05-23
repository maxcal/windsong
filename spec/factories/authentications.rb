FactoryGirl.define do
  factory :authentication do |a|
    a.provider 'facebook'
    a.uid '1234567'
    a.token 'ABCDEF...' # OAuth 2.0 access_token, which you may wish to store
    a.expires_at Time.at(1321747205) # when the access token expires (it always will)
    a.association :user
  end
end
