require 'spec_helper'

describe Notification do

  it { should respond_to :event }
  it { should respond_to :message }
  it { should respond_to :read }
  it { should respond_to :level }

  describe "level" do
    it "should not validate a value not in LEVELS_RFC_5424" do
      subject.level = :foo
      expect(subject.valid?).to be_false
    end
  end

  describe "#level=" do
    it "maps symbols to numeric values" do
      subject.level = 300
      expect(subject.level).to eq :warning
    end
  end

end
