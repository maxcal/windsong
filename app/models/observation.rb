class Observation
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  belongs_to :station

  field :speed, type: Float

end