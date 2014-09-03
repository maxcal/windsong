require "spec_helper"

describe StationMailer do

  let(:event) { build_stubbed(:station_event, station: build_stubbed(:station, name: 'Monkey Island')) }
  let(:user) { build_stubbed(:user) }

  shared_examples_for "a mailer" do
    its(:to) { should eq([user.email]) }
    it "sends email to recipient" do
      expect(ActionMailer::Base.deliveries).to include(mail)
    end

    it "logs an error if email cannot be sent" do
      Mail::Message.any_instance.stub(:deliver).and_return(false)
      Rails.logger.should_receive(:error) do |msg|
        expect(msg).to match("Mail could not be delivered")
        expect(msg).to match("StationMailer.#{ _method }")
      end
      mail
    end
  end

  describe "#online" do
    subject(:mail) { StationMailer.online(user, event) }
    let(:_method) { "online" }
    its(:subject) { should match "Monkey Island has started to respond" }
    it_behaves_like "a mailer"
  end

  describe "#offline" do
    subject(:mail) { StationMailer.offline(user, event) }
    let(:_method) { "offline" }
    its(:subject) { should match "Monkey Island has not responded in a while" }
    it_behaves_like "a mailer"
  end

  describe "#low_balance" do
    subject(:mail) { StationMailer.low_balance(user, event) }
    let(:_method) { "low_balance" }
    its(:subject) { should match "Monkey Island has a low balance" }
    it_behaves_like "a mailer"
  end

end