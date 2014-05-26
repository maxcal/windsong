class Location
  include Mongoid::Document

  # @!attribute lat
  #   Latitude in degrees decimal
  #   @return (Float)
  field :lat, type: Float
  # @!attribute lng
  #   longitude in degrees decimal
  #   @return (Float)
  field :lng, type: Float
  # @!attribute timezone
  #   Timezone in ActiveSupport::TimeZone compatible format
  #   @see ActiveSupport::TimeZone
  #   @return (String)
  field :timezone, type: String

  # Allow long format coordinates
  alias_attribute :latitude, :lat
  alias_attribute :longitude, :lng

  # Validations
  validates_uniqueness_of :lat, scope: :lng
  validates_numericality_of :lat, :lng, allow_nil: true
  validates_inclusion_of :timezone, in: ActiveSupport::TimeZone::MAPPING.values, allow_nil: true

  embedded_in :station

end