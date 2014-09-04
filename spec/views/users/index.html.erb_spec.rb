require 'spec_helper'

describe "users/index.html.erb" do

  let(:user) { build_stubbed(:user) }

  before do
    assign(:users, [user])
    render template: 'users/index'
  end

  subject { rendered }
  it { should have_link 'Joe.bloggs' }
end