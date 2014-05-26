# Shared behavior for observations and forecasts
module WeatherUnit
  extend ActiveSupport::Concern

  included do
    field :min, type: Float # WS min M/S
    field :speed, type: Float # M/S
    field :gust, type: Float # WS max M/S
    field :direction, type: Float # degrees
    field :temperature, type: Float # degrees centigrade

    alias_attribute :max, :gust

    validates_numericality_of :min, :speed, :gust, :temperature, allow_nil: true
    validates_numericality_of :direction,
                              greater_than_or_equal_to: 0,
                              less_than_or_equal_to: 360,
                              allow_nil: true
  end
end