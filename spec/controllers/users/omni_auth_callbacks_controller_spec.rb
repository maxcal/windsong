require 'spec_helper'

describe Users::OmniAuthCallbacksController do

  include Devise::TestHelpers
  include OmniAuthSpecHelper

  before(:each) do
    request.env["devise.mapping"] = Devise.mappings[:user]
    request.env["omniauth.auth"] = {
        provider: 'facebook',
        uid: '1234567',
        info: {
            nickname: 'jbloggs',
            email: 'joe@bloggs.com',
            name: 'Joe Bloggs',
            first_name: 'Joe',
            last_name: 'Bloggs',
            image: 'http://graph.facebook.com/1234567/picture?type=square',
            urls: { Facebook: 'http://www.facebook.com/jbloggs' },
            location: 'Palo Alto, California',
            verified: true
        },
        credentials: {
            token: 'ABCDEF...', # OAuth 2.0 access_token, which you may wish to store
            expires_at: 1321747205, # when the access token expires (it always will)
            expires: true # this will always be true
        }
    }
  end

  describe "GET 'facebook'" do
    context "if auth response is valid" do

      before do
        valid_credentials(:facebook)
      end

      it "redirects to home" do
        get :facebook
        expect(response).to redirect_to root_path
      end

      it "signs the user in" do
        get :facebook
        expect(controller.current_user.email).to eq 'joe@bloggs.com'
      end

      context 'when neither user or auth exists' do
        it 'creates a new user' do
          expect {
            get :facebook
          }.to change(User, :count).by(+1)
        end
        it 'creates a new authentication' do
          get :facebook
          expect(assigns(:authentication)).to be_a Authentication
          expect(assigns(:authentication)).to be_persisted
        end
        it 'assigns the user as @user' do
          get :facebook
          expect(assigns(:user)).to be_a User
        end
      end

      context 'when user exists' do
        let!(:user) { create(:user, email: 'joe@bloggs.com') }

        it 'should not create a new user' do
          expect {
            get :facebook
          }.to_not change(User, :count)
        end
        it 'finds the correct user and assigns the user as @user' do
          get :facebook
          expect(assigns(:user).id).to eq user.id
        end
        it 'creates a new authentication' do
          get :facebook
          expect(assigns(:authentication)).to be_persisted
        end
      end

      context 'when user and authentication exists' do
        let!(:user) { create(:user, email: 'joe@bloggs.com') }
        let!(:auth) { create(:authentication, user: user, provider: 'facebook', uid: '1234567') }

        it 'should not create a new user' do
          expect {
            get :facebook
          }.to_not change(User, :count)
        end
      end
    end
  end
end
