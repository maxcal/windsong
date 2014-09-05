require 'spec_helper'

describe "users/_menu.html.erb" do

  subject { rendered }

  context 'when user is not signed in' do
    before do
      view.stub(:user_signed_in?).and_return(false)
      view.stub(:current_user).and_return(nil)
      render partial: 'users/menu'
    end

    it { should have_link 'Log in', href: new_user_session_path }
    it { should have_link 'Register', href: new_user_registration_path }
    it { should_not have_link 'My profile', href: current_user_path }
  end

  context 'when user is signed in' do
    let(:user) { build_stubbed(:user) }

    before do
      view.stub(:user_signed_in?).and_return(true)
      view.stub(:current_user).and_return(user)
      render partial: 'users/menu'
    end

    it { should_not have_link 'Log in', href: new_user_session_path }
    it { should_not have_link 'Register', href: new_user_registration_path }
    it { should have_link 'My profile', href: current_user_path }
  end
end