require 'spec_helper'

feature "User pages" do

  let(:user) { create(:user) }

  context "index page" do
    background do
      user
      visit users_path
    end

    scenario 'when I visit the index of users' do
      expect(page).to have_link 'Joe.bloggs'
    end
  end

  context "user page" do
    background do
      user
      visit users_path
      click_link 'Joe.bloggs'
    end

    scenario 'when I click a username' do
      expect(page).to have_content 'joe.bloggs'
    end
  end

  context "profile page" do
    let!(:user) { create_user_and_sign_in }

    background do
      click_link 'Profile'
    end

    scenario 'when I visit the profile page' do
      expect(page).to have_link 'Edit'
      expect(page).to have_link 'My public profile'
    end
  end
end