require 'spec_helper'

describe StationSerializer do

  let(:resource) { create(:station, custom_slug: 'foo') }
  let(:serializer) { StationSerializer.new(resource) }

  subject { serializer.serializable_hash }

  its([:id]) { should eq resource[:id] }
  its([:name]) { should eq resource[:name] }

  it "includes the slug" do
    expect(subject[:slug]).to eq('foo')
  end
  
end