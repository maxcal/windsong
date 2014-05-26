require 'spec_helper'

describe Observation do

  it { should respond_to :created_at }
  it { should respond_to :station }

  it { should respond_to :speed }

end
