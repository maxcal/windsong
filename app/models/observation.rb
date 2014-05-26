class Observation
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  belongs_to :station

  field :speed, type: Float

  validates_numericality_of :speed

end