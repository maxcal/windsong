# A weather observation as recorded by the parent Station
class Observation
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  # @!attribute station
  #   The station where this observation was created
  #   @return (Station)
  belongs_to :station

  include WeatherUnit
  # WeatherUnit provides the following attributes:
  # @!attribute min
  #   Wind speed min in M/S
  #   @return (Float)
  # @!attribute speed
  #   Wind speed in M/S
  #   @return (Float)
  # @!attribute gust
  #   Wind speed maximum in M/S
  #   @return (Float)
  # @!attribute direction
  #   degrees
  #   @return (Float)
  # @!attribute temperature
  #   degrees centigrade
  #   @return (Float)
end