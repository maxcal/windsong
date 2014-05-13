require 'spec_helper'

feature 'Profile page' do

  let!(:user) { create_user_and_sign_in }

  scenario 'when I visit my profile' do
    click_link 'Profile'
    expect(page).to have_link 'Edit'
  end

end