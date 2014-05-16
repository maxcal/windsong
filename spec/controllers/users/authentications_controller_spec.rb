require 'spec_helper'

describe Users::AuthenticationsController do

  describe "GET 'delete'" do

    before do
      stub_request(:delete, "http://http//graph.facebook.com:80/1234567/permissions/ABCDEF...").
          to_return(status: 200, body: "TRUE", headers: {})
    end

    let!(:auth) { create(:authentication) }
    let(:params) { { id: auth.to_param, user_id: auth.user.to_param  } }

    it "deletes authentication" do
      get :delete, params
      expect(assigns(:user).authentications.count).to eq 0
    end

    it "logs error if Facebook does not revoke permissions" do
      Rails.logger.should_receive(:error).with("Attempted to revoke app permissions for #{auth.user.id}, " +
                                                   "but received a negative response from Facebook.")
      stub_request(:delete, "http://http//graph.facebook.com:80/1234567/permissions/ABCDEF...").
          to_return(status: 200, body: "FALSE", headers: {})
      get :delete, params
    end

    it "redirects to root path" do
      get :delete, params
      expect(response).to redirect_to root_path
    end

  end
end
