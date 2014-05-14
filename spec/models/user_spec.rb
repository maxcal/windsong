require 'spec_helper'

describe User do

  it { should validate_uniqueness_of :username }

  it "should slug username" do
    user = create(:user, username: 'foo')
    expect(user.slug).to eq 'foo'
  end

  describe '.find_or_create_from_omniauth_hash' do

    let(:auth_hash) do
      {
          :provider => 'facebook',
          :uid => '1234567',
          :info => {
              :nickname => 'jbloggs',
              :email => 'joe@bloggs.com',
              :name => 'Joe Bloggs',
              :first_name => 'Joe',
              :last_name => 'Bloggs',
              :image => 'http://graph.facebook.com/1234567/picture?type=square',
              :urls => { :Facebook => 'http://www.facebook.com/jbloggs' },
              :location => 'Palo Alto, California',
              :verified => true
          },
      }
    end

    context 'if user with given email exists' do
      let!(:user) { create :user }
    end

  end

end