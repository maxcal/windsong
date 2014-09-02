class Event
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  field :key, type: Symbol
  field :meta, type: String
  has_many :notifications
  attr_readonly :key, :meta
  belongs_to :station, inverse_of: :events

end