require 'spec_helper'

describe UsersController do

  let(:user) { create(:user) }
  subject { response }

  describe "GET 'show'" do
    before { get 'show', id: user.to_param }
    it { should be_successful }
    it { should render_template :show }
    it "should assign @user" do
      expect(assigns(:user).id).to eq user.id
    end
  end

  describe "GET 'index'" do
    before do
      user
      get 'index'
    end
    it { should be_successful }
    it { should render_template :index }
    it "should assign @users" do
      expect(assigns(:users).size).to eq 1
    end
  end

end
