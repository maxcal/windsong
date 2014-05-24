class Location
  include Mongoid::Document

  field :lat, type: Float
  field :lng, type: Float
  field :timezone, type: String

  # Allow long format coordinates
  alias_attribute :latitude, :lat
  alias_attribute :longitude, :lng

  # Validations
  validates_numericality_of :lat, :lng, allow_nil: true
  validates_inclusion_of :timezone, in: ActiveSupport::TimeZone::MAPPING.values, allow_nil: true

  embedded_in :station

end