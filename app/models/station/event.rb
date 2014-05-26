# Used to log and notifity events such as a station going offline
class Station::Event
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  belongs_to :station

  field :key, type: String
  field :meta, type: String

  attr_readonly :key, :meta
end