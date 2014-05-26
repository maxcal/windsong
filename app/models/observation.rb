class Observation
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include WeatherUnit

  belongs_to :station
end