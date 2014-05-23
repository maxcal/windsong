require 'spec_helper'

describe Location do

  include Windsong::Responses::Geonames

  it { should validate_numericality_of :lat }
  it { should validate_numericality_of :lng }
  it { should respond_to :latitude }
  it { should respond_to :longitude }
  it { should respond_to :timezone }

  it { should allow_value("Pacific/Midway").for(:timezone) }
  it { should_not allow_value("foo").for(:timezone) }

end
