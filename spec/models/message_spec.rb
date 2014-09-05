require 'spec_helper'

describe Message do

  it { should respond_to :event }
  it { should respond_to :subject }
  it { should respond_to :body }
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

  describe "send_mail!!" do

    let(:message) do
      create(:message,
             mailer: double("ActionMailer::Base"),
             recipient: build_stubbed(:user),
             event: build_stubbed(:event, key: :foo))
    end

    it "should send mail" do
      message.mailer.should_receive(:foo)
      message.send_mail!
    end

  end
end
