require 'spec_helper'

feature 'Authentication' do

  context 'when I sign up' do

    background do
      visit '/users/sign_up'
      fill_in 'Email', with: 'foo@example.com'
      fill_in 'Password', with: 'Pazzwurd'
      fill_in 'Password confirmation', with: 'Pazzwurd'
    end

    scenario 'with an invalid email' do
      fill_in 'Email', with: 'foo'
      expect {
        click_button 'Sign up'
      }.to_not change(User, :count)
      expect(page).to have_content 'Email is invalid'
    end

    scenario 'with an invalid password' do
      fill_in 'Password', with: 'a'
      expect {
        click_button 'Sign up'
      }.to_not change(User, :count)
      expect(page).to have_content 'Password is too short'
    end

    scenario 'with a confirmation that does not match password' do
      fill_in 'Password confirmation', with: 'a'
      expect {
        click_button 'Sign up'
      }.to_not change(User, :count)
      expect(page).to have_content "Password confirmation doesn't match Password"
    end

    scenario 'with valid input' do
      expect {
        click_button 'Sign up'
      }.to change(User, :count).by(+1)
      expect(page).to have_content "Welcome! You have signed up successfully."
    end
  end

  context 'when I sign in' do

    let!(:user) { create(:user) }
    background do
      visit '/users/sign_in'
    end

    scenario 'with invalid details' do
      fill_in 'Email', with: 'does-not-exist@example.com'
      fill_in 'Password', with: 'sdasdasd'
      click_button 'Sign in'
      expect(page).to have_content 'Invalid email or password'
    end

    scenario 'with valid details' do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign in'
      expect(page).to have_content 'Signed in successfully.'
    end
  end
end