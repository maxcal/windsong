require 'spec_helper'

describe User do

  it { should validate_uniqueness_of :username }

  it "should slug username" do
    user = create(:user, username: 'foo')
    expect(user.slug).to eq 'foo'
  end

end