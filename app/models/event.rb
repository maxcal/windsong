class Event
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  field :key, type: Symbol
  field :meta, type: String
  attr_readonly :key, :meta
end