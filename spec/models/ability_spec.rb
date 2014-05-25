require 'spec_helper'
require 'cancan/matchers'

describe Ability do

  subject { Ability.new(user) }

  let(:user) { build_stubbed(:user) }
  let(:auth) { build_stubbed(:authentication, user: user) }

  # Should be able to manage self
  it { should be_able_to(:crud, user) }
  # But not others
  it { should_not be_able_to(:manage, User) }
  # Should be able to manage own authentications
  it { should be_able_to(:manage, auth) }
  # But not others
  it { should_not be_able_to(:manage, build_stubbed(:authentication)) }

  it { should be_able_to(:read, Station) }


  context "an admin" do
    before do
      User.any_instance.stub(:has_role?).with(:admin).and_return(true)
    end

    it { should be_able_to(:manage, User) }
    it { should be_able_to(:manage, Authentication) }
    it { should be_able_to(:manage, Station) }
  end
end