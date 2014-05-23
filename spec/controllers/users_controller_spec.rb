require 'spec_helper'

describe UsersController do

  let(:user) { create(:user) }
  subject { response }

  describe "GET 'show'" do
    before do
      get 'show', id: user.to_param
    end
    it { should be_successful }
    it { should render_template :show }
    it "should assign @user" do
      expect(assigns(:user).id).to eq user.id
    end

    context "when :id parameter is a username" do
      before do
        get 'show', id: user.slug
      end
      it { should be_successful }
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

  describe "GET 'me'" do
    before do
      user
      controller.stub(:current_user).and_return(user)
      get :me
    end
    it { should be_successful }
    it { should render_template :me }
    it "should assign @user" do
      expect(assigns(:user).id).to eq user.id
    end
  end

end
