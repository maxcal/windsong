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

    let(:user) { build_stubbed(:user) }

    context "when station was online" do

      let(:station){ create(:station, online: true) }

      context "and remains online" do
        # Essentially nothing should happen here.
        # test that notifications are not sent
        before(:each) do
          station.stub(:should_be_offline?).and_return(false)
        end

        it "is still online" do
          station.check_status!
          expect(station.online?).to be_true
        end

        it "does not notify owners" do
          station.should_not_receive(:notify_online)
          station.should_not_receive(:notify_offline)
          station.check_status!
        end
      end

      context "and becomes offline" do
        # Essentially nothing should happen here.
        # test that notifications are not sent
        before(:each) do
          station.stub(:should_be_offline?).and_return(true)
        end
        specify "station should be offline" do
          station.check_status!
          expect(station.offline?).to be_true
        end
        it "should notify that station is offline" do
          station.should_receive(:notify_offline)
          station.check_status!
        end
      end
    end

    context "when station was offline" do

      let(:station){ create(:station, online: false) }

      context "and becomes online" do
        # Essentially nothing should happen here.
        # test that notifications are not sent
        before(:each) do
          station.stub(:should_be_offline?).and_return(false)
        end
        it "should be online" do
          station.check_status!
          expect(station.online?).to be_true
        end
        it "should not notify" do
          station.should_receive(:notify_online)
          station.check_status!
        end
      end

      context "and should remain offline" do
        # Essentially nothing should happen here.
        # test that notifications are not sent
        before(:each) do
          station.stub(:should_be_offline?).and_return(true)
        end
        it "should not send message" do
          station.should_not_receive(:notify_online)
          station.check_status!
        end
        it "should still be offline" do
          station.check_status!
          expect(station.offline?).to be_true
        end
      end
    end
  end

end