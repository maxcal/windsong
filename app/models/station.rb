class Station
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  include Presentable

  embeds_one :location
  has_many :observations
  has_many :events, class_name: 'Station::Event'

  field :name, type: String
  field :hardware_uid, type: String

  validates_presence_of :name, :hardware_uid
  validates_uniqueness_of :hardware_uid

  slug :name, reserved: %w[find, station, stations, observations]
end