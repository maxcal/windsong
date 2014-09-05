require 'spec_helper'

feature "Facebook Authentication" do

  include OmniAuthSpecHelper

  scenario "I should be able to login with facebook from login page" do
    visit new_user_session_path
    expect(page).to have_link "Sign in with Facebook"
  end

  context 'given a valid authentication provider response' do
    background do
      OmniAuth.config.mock_auth[:facebook] = valid_credentials_hash
    end
    scenario 'I should be authenticated' do
      visit new_user_registration_path
      click_link "Sign in with Facebook"
      expect(page).to have_content 'Successfully authenticated from Facebook account.'
    end
  end

  context 'given a invalid authentication provider response' do
    background do
      OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
    end
    scenario 'I should get a message telling me that authentication failed' do
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
    scenario 'I should be able to remove my facebook authentication' do
      click_link "My profile"
      click_link "remove"
      expect(page).to have_content("Facebook authentication deleted.")
    end
  end

  context 'when authenticating with locale' do
    background do
      OmniAuth.config.mock_auth[:facebook] = valid_credentials_hash
    end
    scenario 'I should be directed back to page with the same locale' do
      visit new_user_registration_path(locale: 'sv')
      click_link "Logga in med Facebook"
      expect(current_path).to match "/sv" # sanity test - does not test translations
      expect(page).to have_content 'Autentiserat med Facebook-konto.'
    end
  end
end