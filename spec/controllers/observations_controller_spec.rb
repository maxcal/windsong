require 'spec_helper'

describe ObservationsController do

  let!(:station) { create(:station) }

  before :each do
    sign_out :user
  end

  describe "GET 'index'" do

    before { get :index, station_id: station.to_param }
    subject { response }

    it { should be_successful }
    it { should render_template :index }

  end

  describe "POST 'create'" do

    let(:params) do
      {
          station_id: station.to_param,
          observation: { speed: 'nan' }
      }
    end

    context "when parameters are invalid" do

      it "does not create an observation" do
        expect {
          post :create, params
        }.to_not change(Observation, :count)
      end

      it "returns unproccessable entity" do
        post :create, params
        expect(response).to be_unprocessable
      end
    end

    context "when parameters are valid" do

      let(:attributes) { attributes_for(:observation) }

      before do
        params[:observation] = attributes
      end

      it "creates an observation" do
        expect {
          post :create, params
        }.to change(Observation, :count).by(1)
      end

      it "returns created" do
        post :create, params
        expect(response.status).to eq 302
      end
    end
  end
end
