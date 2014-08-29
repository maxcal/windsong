class Station
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  include Presentable

  # Relations
  embeds_one :location
  has_many :observations
  embeds_one :latest_observation, class_name: 'Observation'
  has_many :events, class_name: 'Station::Event'

  # @attribute [rw]
  field :name, type: String
  # @attribute [rw]
  field :hardware_uid, type: String
  # @attribute [rw]
  field :custom_slug, type: String
  # @attribute [rw]
  field :online, type: Boolean

  # @attribute slug [r]
  slug :custom_slug, reserved: %w[find, station, stations, observations, new]

  validates_presence_of :name, :hardware_uid
  validates_uniqueness_of :hardware_uid

  # Slug name if no custom_slug
  before_validation do |doc|
    if doc.custom_slug.blank?
      doc.custom_slug = name
    end
  end

  def offline?
    !online?
  end


end