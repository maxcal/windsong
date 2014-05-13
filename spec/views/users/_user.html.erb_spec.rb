require 'spec_helper'

describe "users/_user.html.erb" do

  let(:user) { build_stubbed(:user) }

  before do
    render partial: 'users/user', locals: { user: user }
  end

  subject { rendered }

  it { should have_content user.email }

end