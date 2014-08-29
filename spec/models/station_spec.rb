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
    let(:station) { build_stubbed(:station, online: true) }
    it "reports if station is offline" do
      expect(station.offline?).to be_false
      station.online = false
      expect(station.offline?).to be_true
    end
  end

end