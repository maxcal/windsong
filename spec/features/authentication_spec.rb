require 'spec_helper'

feature 'Authentication' do

  context 'when I sign up' do

    background do
      visit '/users/sign_up'
      fill_in 'Username', with: 'joe.bloggs'
      fill_in 'Email', with: 'foo@example.com'
      fill_in 'Password', with: 'Pazzwurd', match: :prefer_exact
      fill_in 'Password confirmation', with: 'Pazzwurd', match: :prefer_exact
    end

    scenario 'with an invalid email' do
      fill_in 'Email', with: 'foo'
      expect {
        click_button 'Sign up'
      }.to_not change(User, :count)
      expect(page).to have_content 'Emailis invalid'
    end

    scenario 'with an invalid password' do
      fill_in 'Password', with: 'a', match: :prefer_exact
      expect {
        click_button 'Sign up'
      }.to_not change(User, :count)
      expect(page).to have_content 'Passwordis too short'
    end

    scenario 'with a confirmation that does not match password' do
      fill_in 'Password confirmation', with: 'a', match: :prefer_exact
      expect {
        click_button 'Sign up'
      }.to_not change(User, :count)
      expect(page).to have_content "Password confirmationdoesn't match Password"
    end

    scenario 'with valid input' do
      expect {
        click_button 'Sign up'
      }.to change(User, :count).by(+1)
      expect(page).to have_content "Welcome! You have signed up successfully."
      user = User.last
      expect(user.email).to eq 'foo@example.com'
      expect(user.username).to eq 'joe.bloggs'
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