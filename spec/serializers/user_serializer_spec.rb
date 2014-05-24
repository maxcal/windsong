require 'spec_helper'

describe UserSerializer do

  let(:resource) { build_stubbed(:user) }

  its([:id]) { should eq resource[:id] }
  its([:username]) { should eq resource[:username] }
end