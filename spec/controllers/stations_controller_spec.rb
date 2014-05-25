require 'spec_helper'

describe StationsController do

  let(:user) { create(:admin) }

  before :each do

    if example.metadata[:authorized]
      sign_in user
    else
      sign_out :user
    end
  end

  describe "GET 'new'" do

    it "should require authorization" do
      expect {
        get :new
      }.to raise_error(CanCan::AccessDenied)
    end

    context "when authorized", authorized: true do
      it "is successful" do
        get :new
        expect(response).to be_success
      end

      it "assigns a new Station as @station" do
        get :new
        expect(assigns(:station)).to be_a_new_record
      end

      it "renders the correct template" do
        get :new
        expect(response).to render_template :new
      end
    end
  end

  describe "GET 'index'" do

    it "is successful" do
      get :index
      expect(response).to be_success
    end

    it "renders the correct template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "POST 'create'" do

    let(:params) { { station: { name: '' }} }

    it "should require authorization" do
      expect {
        post :create, { station: { name: '' }}
      }.to raise_error(CanCan::AccessDenied)
    end

    context "when authorized", authorized: true  do

      before(:each) do
        post :create, params
      end

      context "with invalid params" do

        it "does not create a station" do
          expect(Station.count).to eq 0
        end

        it "should render create form" do
          expect(response).to render_template :new
        end
      end

      context "with valid params" do

        let(:params) { { station: attributes_for(:station) } }

        it "should create a station" do
          expect(Station.count).to eq 1
        end

      end
    end
  end
end
