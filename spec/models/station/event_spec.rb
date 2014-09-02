require 'spec_helper'

describe Station::Event do
  let(:user) { create(:user) }
  let(:station) do
    create(:station) do |station|
      station.name = 'Test Station'
      station.owners << user
    end
  end

  let(:event) { create(:station_event, key: :online, station: station) }

  describe "#notify" do
    it "creates a notification" do
      expect { event.notify }.to change( event.notifications, :count ).by(+1)
    end

    it "notifies owners" do
      expect( event.notify.last.recipient ).to eq(user)
    end

    it "has the correct message" do
      event.key = :online
      expect( event.notify.last.message ).to eq('Test Station is online')
    end
  end
end