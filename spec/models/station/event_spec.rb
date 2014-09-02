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
      expect(event.can_notify?).to be_true

      expect { event.notify }.to change( event.notifications, :count ).by(+1)
    end

    it "notifies owners" do
      expect( event.notify.last.recipient ).to eq(user)
    end

    it "has the correct message" do
      event.key = :online
      expect( event.notify.last.message ).to eq('Test Station is online')
    end

    it "only allows notify once" do
      event.notify
      expect { event.notify }.to_not change( event.notifications, :count )
      expect { event.nofied? }.to be_true
    end
  end

  describe "event throttling" do

    let(:event) { create(:station_event, key: :low_balance, station: station) }

    context "when a previous event was notified in the cool-down period" do
      let!(:old_event) do
        e = create(:station_event, key: :low_balance, station: station, notified: true)
      end
      it "should not allow new notifications" do
        expect { event.notify }.to_not change( event.notifications, :count )
      end
    end

    context "when a previous event is older than the cool-down" do
      let!(:old_event) do
        e = create(:station_event, key: :low_balance, station: station, notified: true)
        e.update_attribute(:created_at, 2.years.ago)
        e
      end
      it "should allow new notifications" do
        expect { event.notify }.to change( event.notifications, :count ).by(+1)
      end
    end
  end
end