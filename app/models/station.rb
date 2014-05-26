class Station
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  include Presentable

  embeds_one :location
  has_many :observations
  has_many :events, class_name: 'Station::Event'

  # @attribute [rw]
  field :name, type: String
  # @attribute [rw]
  field :hardware_uid, type: String

  validates_presence_of :name, :hardware_uid
  validates_uniqueness_of :hardware_uid

  # @attribute slug [rw]
  slug :name, reserved: %w[find, station, stations, observations]
end