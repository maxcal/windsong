class Event
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  field :key, type: Symbol
  field :meta, type: String
  field :notified, type: Boolean

  has_many :notifications
  attr_readonly :key, :meta
end