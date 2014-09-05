# Shared attributes for observations and forecasts
module WeatherUnit
  extend ActiveSupport::Concern

  included do
    # WeatherUnit provides the following attributes:
    # @!attribute min
    #   Wind speed min in M/S
    #   @return (Float)
    field :min, type: Float # WS min M/S
    # @!attribute speed
    #   Wind speed in M/S
    #   @return (Float)
    field :speed, type: Float # M/S
    # @!attribute gust
    #   Wind speed maximum in M/S
    #   @return (Float)
    field :gust, type: Float
    # @!attribute direction
    #   degrees
    #   @return (Float)
    field :direction, type: Float
    # @!attribute temperature
    #   degrees centigrade
    #   @return (Float)
    field :temperature, type: Float

    alias_attribute :max, :gust

    validates_numericality_of :min, :speed, :gust, :temperature, allow_nil: true
    validates_numericality_of :direction,
                              greater_than_or_equal_to: 0,
                              less_than_or_equal_to: 360,
                              allow_nil: true
  end
end