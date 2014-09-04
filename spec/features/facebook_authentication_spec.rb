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
      expect(page).to have_content 'Could not authenticate you from Facebook because "Invalid credentials"'
    end
  end

  context 'when authenticated' do
    background do
      OmniAuth.config.mock_auth[:facebook] = valid_credentials_hash
      visit new_user_registration_path
      click_link "Sign in with Facebook"
      stub_request(:delete,  /graph.facebook.com.*/)
    end
    scenario 'when I remove my facebook authentication' do
      click_link "Profile"
      click_link "remove"
      expect(page).to have_content("Facebook authentication deleted.")
    end
  end
end