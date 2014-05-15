require 'spec_helper'

feature "Facebook Authentication" do

  include OmniAuthSpecHelper

  context 'given a valid authentication provider response' do
    background do
      OmniAuth.config.mock_auth[:facebook] = valid_credentials_hash
    end
    scenario 'when I am on signup page and click facebook logo' do
      visit new_user_registration_path
      click_link "Sign in with Facebook"
      expect(page).to have_content 'You signed in successfully!'
    end
  end

  context 'given a invalid authentication provider response' do
    background do
      OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
    end

    scenario 'when I am on signup page and click facebook logo' do
      visit new_user_registration_path
      click_link "Sign in with Facebook"
      expect(page).to have_content 'translation missing: en.devise.omni_auth_callbacks.user.failure'
    end
  end
end