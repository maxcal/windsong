# A weather observation as recorded by the parent Station
class Observation
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  # @!attribute station
  #   The station where this observation was created
  #   @return (Station)
  belongs_to :station, inverse_of: :observations

  # scopes
  scope :since, ->(time_ago){ where(:created_at.gte => time_ago) }
  include WeatherUnit
end