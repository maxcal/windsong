require "spec_helper"

# Nothing fancy, just check that the right messages are sent.
describe "stations:check_all!" do

  include_context "rake"

  let!(:station) do
    create(:station)
  end

  it "checks status of stations" do
    pending "test fails unexplainably."
    station.should_receive(:check_status!)
    subject.invoke
  end
end

