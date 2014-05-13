require 'spec_helper'

describe "users/show.html.erb" do

  let(:user) { build_stubbed(:user) }

  before do
    assign(:user, user)
    render
  end

  subject { rendered }

  it { should have_content user.username }

end
