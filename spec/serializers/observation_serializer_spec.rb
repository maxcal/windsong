require 'spec_helper'

describe ObservationSerializer do

  let(:resource) { create(:observation) }

  its([:id]){ should eq resource[:id] }
  its([:speed]){ should eq resource[:speed] }

end