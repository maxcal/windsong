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
      expect(page).to have_content "A message with a confirmation link has been sent to your email address. "+
                                   "Please open the link to activate your account."
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

  context 'when I edit my profile' do

    let!(:user) { create_user_and_sign_in }

    background do
      visit edit_user_registration_path
      fill_in 'Current password', with: user.password
    end


    scenario 'I should be able to change my username' do
      fill_in 'Username', with: 'foobarbaz'
      click_button 'Update'
      expect(page).to have_content 'You updated your account successfully'
      expect(User.last.username).to eq 'foobarbaz'
    end

    scenario 'I should recieve a confirmation email if I change my email' do
      visit edit_user_registration_path
      fill_in 'Email', with: 'foo1@bar.com'
      fill_in 'Current password', with: user.password
      expect {
        click_button 'Update'
      }.to_not change(User.last, :email)

      mail = ActionMailer::Base.deliveries.last
      expect(page).to have_content 'You updated your account successfully'
      expect(mail.subject).to eq "Confirmation instructions"
    end

  end

end