require 'spec_helper'

feature 'Profile page' do

  let!(:user) { create_user_and_sign_in }

  scenario 'when I visit my profile' do
    click_link 'Profile'
    expect(page).to have_link 'Edit'
  end

  scenario 'I edit my profile' do
    visit edit_user_registration_path
    fill_in 'Email', with: 'foo@bar.com'
    fill_in 'Username', with: 'foobarbaz'
    fill_in 'Current password', with: user.password
    click_button 'Update'
    expect(page).to have_content 'You updated your account successfully'
    actual = User.last
    expect(actual.username).to eq 'foobarbaz'
    expect(actual.email).to eq 'foo@bar.com'
  end

end