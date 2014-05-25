class Station
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  field :name, type: String
  field :hardware_uid, type: String

  embeds_one :location

  validates_presence_of :name, :hardware_uid

  validates_uniqueness_of :hardware_uid

  slug :name, reserved: %w[user, owner, station, stations, observations]

end