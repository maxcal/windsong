require 'spec_helper'

describe Users::OmniauthController do
  describe "GET 'localized'" do

    before(:each) do
      I18n.locale = 'en'
    end

    it "returns http success" do
      get :localized, provider: :facebook
    end

    it "sets locale in session" do
      get :localized, provider: :facebook
      expect(session[:omniauth_login_locale]).to eq :en
    end

  end
end
