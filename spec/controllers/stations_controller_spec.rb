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

  describe "GET 'show'" do

    let!(:station) { create(:station) }

    before { get :show, id: station.to_param }

    subject { response }

    it { should be_successful }
    it { should render_template :show }

    it "assigns the correct station as @station" do
      expect(assigns(:station).id).to eq station.id
    end

  end


  describe "GET edit" do

    let!(:station) { create(:station) }

    it "should require authorization" do
      expect {
        get :edit, id: station.to_param
      }.to raise_error(CanCan::AccessDenied)
    end

    context "when authorized", authorized: true do

      before { get :edit, id: station.to_param }
      subject { response }

      it { should be_successful }
      it { should render_template :edit }
    end

  end

  describe "PATCH 'update'" do
    let!(:station) { create(:station) }

    it "should require authorization" do
      expect {
        patch :update, id: station.to_param, station: { name: 'foobar' }
      }.to raise_error(CanCan::AccessDenied)
    end

    context "when authorized", authorized: true do

      context "with invalid params" do

        before do
          patch :update, id: station.to_param, station: { name: '' }
        end

        it "renders edit template" do
          expect(response).to render_template :edit
        end

        it "returns 422 / Unproccessable Entity" do
          expect(response).to be_unprocessable
        end
      end

      before do
        patch :update, id: station.to_param, station: { name: 'foobar' }
        station.reload
      end

      it "should update station" do
        expect(station.name).to eq 'foobar'
      end

      it "should redirect to station" do
        expect(response).to redirect_to station_path(station.to_param)
      end
    end
  end
end
