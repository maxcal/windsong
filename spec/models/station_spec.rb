require 'spec_helper'

describe Station do

  it { should respond_to :created_at }
  it { should respond_to :updated_at }
  it { should respond_to :location }
  it { should respond_to :slug }
  it { should validate_uniqueness_of :hardware_uid }
  it { should respond_to :presenter }
  it { should respond_to :observations }
  it { should respond_to :events }

  it "slugs the name" do
    station = Station.create(name: "Foo", hardware_uid: "123")
    expect(station.slug).to eq "foo"
  end

  it "accepts a custom slug" do
    station = Station.create(name: "Foo", custom_slug: "FooBar", hardware_uid: "123")
    expect(station.slug).to eq "foobar"
  end

  describe "offline?" do
    let(:station) { build_stubbed(:station) }
    it "reports if station is offline" do
      station.online = true
      expect(station.offline?).to be_false
      station.online = false
      expect(station.offline?).to be_true
    end
  end

  describe "#should_be_offline?" do
    let(:station) { create(:station) }
    context "when station is younger than 25 min" do
      it "should not be offline" do
        station.update_attribute(:created_at, 1.minute.ago )
        expect(station.should_be_offline?).to be_false
      end
    end
    context "when station has three observations in last 24 min" do
      before :each do
        station.update_attribute(:created_at, 1.year.ago )
        4.times { create(:observation, station: station) }
      end
      it "should not be offline" do
        expect(station.should_be_offline?).to be_false
      end
    end
    context "when station has less than three observations in last 24 min" do
      let(:observations) { [*1..4].map! { create(:observation, station: station) } }
      before :each do
        station.update_attribute(:created_at, 1.year.ago )
        observations.each do |m, index|
          m.update_attribute(:created_at, 1.hours.ago )
        end
      end
      it "should be offline" do
        create(:observation, station: station)
        expect(station.should_be_offline?).to be_true
      end
    end
  end

  describe "check_status!" do
    context "when station becomes offline" do
      let(:station){ create(:station, online: true) }
      before(:each) do
        station.stub(:should_be_offline?).and_return(true)
      end
      it "is offline" do
        station.check_status!
        expect(station.offline?).to be_true
      end
      it "sends notification" do
        Station::Event.any_instance.should_receive(:notify)
        station.check_status!
      end
      it "does not notify if it was already offline" do
        station.online = false
        Station::Event.any_instance.should_not_receive(:notify)
        expect {
          station.check_status!
        }.not_to change(station.events, :count)
      end
      it "creates a station event" do
        expect {
          station.check_status!
        }.to change(station.events, :count).by(+1)
        expect(station.events.last.key).to eq(:offline)
      end
    end

    context "when station comes online" do
      let(:station){ create(:station, online: false) }
      before(:each) do
        station.stub(:should_be_offline?).and_return(false)
      end
      it "is online" do
        station.check_status!
        expect(station.online?).to be_true
      end
      it "does not notify if it was already online" do
        station.online = true
        Station::Event.any_instance.should_not_receive(:notify)
        expect {
          station.check_status!
        }.not_to change(station.events, :count)
      end
      it "creates a station event" do
        expect {
          station.check_status!
        }.to change(station.events, :count).by(+1)
        expect(station.events.last.key).to eq(:online)
      end
      it "sends notification" do
        Station::Event.any_instance.should_receive(:notify)
        station.check_status!
      end

    end
  end
end