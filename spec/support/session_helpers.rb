require 'ostruct'

module SessionHelpers

  # ! for use in features only
  # Create a user and sign them in by filling in form
  # @return User
  def create_user_and_sign_in
    sign_in_user create(:user)
  end

  # ! for use in features only
  # Sign in user by using the actual web frontend
  def sign_in_user(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
    user
  end

  def sign_out_user
    visit root_path
    click_link "Sign out"
  end

end