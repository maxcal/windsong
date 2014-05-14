require 'spec_helper'

describe Authentication do

  it { should allow_value('facebook').for(:provider) }
  it { should_not allow_value('twotter').for(:provider) }
  it { should validate_uniqueness_of :uid }
  it { should validate_presence_of :token }
  it { should validate_presence_of :expires_at }

  let(:auth_hash) do
    {
        provider: 'facebook',
        uid: '1234567',
        credentials: {
            token: 'ABCDEF...', # OAuth 2.0 access_token, which you may wish to store
            expires_at: 1321747205, # when the access token expires (it always will)
        }
    }
  end

  describe '.find_or_create_from_omniauth_hash' do
    context 'if authentication allready exists' do
      let!(:authentication) { create :authentication }

      it "does not create a new authentication" do
        expect {
          actual = Authentication.find_or_create_from_omniauth_hash(auth_hash)
        }.to_not change(Authentication, :count)
      end
      it "returns the exising Authentication" do
        expect(Authentication.find_or_create_from_omniauth_hash(auth_hash).id).to eq authentication.id
      end
    end


    subject { Authentication.find_or_create_from_omniauth_hash(auth_hash) }

    its(:provider) { should eq 'facebook' }
    its(:uid) { should eq '1234567' }
    its(:token) { should eq 'ABCDEF...' }
    its(:expires_at) { should eq Time.at(1321747205) }
  end

  describe "#update_with_omniauth_hash" do

    let(:authentication) { create(:authentication) }
    let(:auth_hash) do
      { credentials: { token: 'newtoken', expires_at: 123 } }
    end

    it "updates authentication from hash" do
      authentication.update_with_omniauth_hash(auth_hash)

      expect(authentication.token).to eq 'newtoken'
      expect(authentication.expires_at).to eq Time.at(123)
    end


  end

end