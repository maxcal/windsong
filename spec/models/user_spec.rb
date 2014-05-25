require 'spec_helper'

describe User do

  include OmniAuthSpecHelper

  it { should validate_uniqueness_of :username }

  it "should slug username" do
    user = create(:user, username: 'foo')
    expect(user.slug).to eq 'foo'
  end

  it { should respond_to :presenter }

  describe '.find_or_create_from_omniauth_hash', :focus => true do

    let(:auth_hash) { valid_credentials_hash }

    context 'given a user with authentication' do

      let!(:user) { create(:user) }
      let!(:auth) { create(:authentication, user: user, uid: '1234567', provider: 'facebook') }

      it "does not create a new user" do
        expect {
          User.find_or_create_from_omniauth_hash(auth_hash)
        }.to_not change(User, :count)
      end

      it "does not create a new authentication" do
        expect {
          User.find_or_create_from_omniauth_hash(auth_hash)
        }.to_not change(Authentication, :count)
      end

      it "returns the user" do
        expect(User.find_or_create_from_omniauth_hash(auth_hash)).to be_a User
      end
    end

    context 'when user with given email exists' do

      let!(:user) { create :user, email: 'joe@bloggs.com' }

      it "does not create a new user" do
        expect {
          User.find_or_create_from_omniauth_hash(auth_hash)
        }.to_not change(User, :count)
      end

      it "returns the user" do
        expect(User.find_or_create_from_omniauth_hash(auth_hash)).to be_a User
      end
    end

    context  'when user does not exist' do
      let(:user) { User.find_or_create_from_omniauth_hash(auth_hash) }

      it "creates a new user" do
        expect {
          User.find_or_create_from_omniauth_hash(auth_hash)
        }.to change(User, :count)
      end

      it "has the correct email" do
        expect(user.email).to eq 'joe@bloggs.com'
      end

      it "has the correct username" do
        expect(user.username).to eq 'jbloggs'
      end

      it "confirms the user" do
        expect(user.confirmed?).to be_true
      end

    end
  end

end