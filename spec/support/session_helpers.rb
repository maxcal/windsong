require 'ostruct'

module SessionHelpers

  # @return User
  def create_user_and_sign_in
    user = create(:user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign in'
    user
  end

end