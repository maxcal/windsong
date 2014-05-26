require 'spec_helper'

describe Observation do

  it { should respond_to :created_at }
  it { should respond_to :station }

  it { should validate_numericality_of :min }
  it { should validate_numericality_of :speed }
  it { should validate_numericality_of :gust }
  it { should validate_numericality_of :direction }
  it { should validate_numericality_of :temperature }
  it { should_not allow_value(-1).for(:direction) }
  it { should_not allow_value(361).for(:direction) }
  it { should allow_value(1).for(:direction) }
  it { should respond_to :max }

end
