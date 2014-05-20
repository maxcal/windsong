require 'spec_helper'

describe Users::AuthenticationsController do

  describe "GET 'delete'" do

    before do
      stub_request(:delete, "http://graph.facebook.com/1234567/users/ABCDEF...").
          to_return(status: 200, body: "TRUE", headers: {})

      sign_in auth.user
    end

    let!(:auth) { create(:authentication) }
    let(:params) { { id: auth.to_param, user_id: auth.user.to_param  } }

    it "deletes authentication" do
      get :destroy, params
      expect(assigns(:user).authentications.count).to eq 0
    end

    it "logs error if Facebook does not revoke permissions" do
      stub_request(:delete, "http://graph.facebook.com/1234567/users/ABCDEF...").
          to_return(status: 200, body: "FALSE", headers: {})
      Rails.logger.should_receive(:error).with("Attempted to revoke app permissions for #{auth.user.id}, " +
                                                   "but received a negative response from Facebook.")
      get :destroy, params
    end

    it "redirects to root path" do
      get :destroy, params
      expect(response).to redirect_to root_path
    end

    it "logs out user" do
      get :destroy, params
      expect(session).to_not have_key "warden.user.user.key"
    end

  end
end
