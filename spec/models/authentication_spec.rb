require 'spec_helper'

describe Authentication do

  subject { create(:authentication) }

  it { should allow_value('facebook').for(:provider) }
  it { should_not allow_value('twotter').for(:provider) }
  it { should validate_presence_of :token }
  it { should validate_presence_of :expires_at }

  let(:hash) do
    {
        provider: 'facebook',
        uid: '1234567',
        credentials: {
            token: 'ABCDEF...', # OAuth 2.0 access_token, which you may wish to store
            expires_at: 1321747205, # when the access token expires (it always will)
        }
    }
  end

  describe ".omniauth_hash_to_attributes" do
    subject { Authentication.omniauth_hash_to_attributes(hash) }
    its([:provider]) { should eq 'facebook' }
    its([:uid]) { should eq '1234567' }
    its([:token]) { should eq 'ABCDEF...' }
    its([:expires_at]) { should eq Time.at(1321747205) }
  end

  describe ".find_or_initialize_from_omniauth_hash" do
    let(:user) { create(:user) }

    subject {  user.authentications.find_or_initialize_from_omniauth_hash(hash) }

    context "new authorization" do
      its(:provider) { should eq 'facebook' }
      its(:uid) { should eq '1234567' }
    end

    context "when authorization exists" do
      let!(:auth) { create(:authentication, user: user) }

      it "returns the exisiting record" do
        expect(subject.id).to eq auth.id
        expect(subject).to_not be_a_new_record
      end
    end
  end

  describe 'update_with_omniauth_hash' do

    let(:user) { create(:user) }

    context 'new record' do
      let(:auth) { user.authentications.find_or_initialize_from_omniauth_hash(hash) }

      it "saves record" do
        auth.update_with_omniauth_hash(hash)
        expect(auth).to be_persisted
      end
    end
  end

  describe "#presenter" do

    let!(:auth) { create(:authentication) }

    it "returns a AuthenticationPresenter" do
      expect(auth.presenter).to be_a AuthenticationPresenter
    end

    it "should be associated with the user" do
      expect(auth.presenter.authentication).to eq auth
    end

    it "memoizes presenter" do
      expect(AuthenticationPresenter).to receive(:new).once.with(auth).and_call_original
      auth.presenter
      auth.presenter
    end
  end
end