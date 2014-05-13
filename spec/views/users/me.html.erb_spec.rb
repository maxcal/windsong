require 'spec_helper'

describe "users/me.html.erb" do

  let(:user) { build_stubbed(:user) }

  before do
    assign(:user, user)
    render
  end

  subject { rendered }

  it { should have_link 'Edit', edit_user_registration_path }
  it { should have_link 'My public profile', user_path(user.to_param) }

end
