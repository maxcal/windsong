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
  has_many :owners, class_name: 'User'

  # @attribute [rw]
  field :name, type: String
  # @attribute [rw]
  field :hardware_uid, type: String
  # @attribute [rw]
  field :custom_slug, type: String
  # @attribute [rw]
  field :online, type: Boolean
  # @attribute [rw] - How often station should receive new observations in seconds
  field :update_frequency, type: Integer, default: 5.minutes.seconds

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

  def offline= bool
    online = !bool
  end

  # Check if station should be offline by checking if it has received 3 out the last 5 obs.
  # @return Boolean
  def should_be_offline?
    time_ago = (update_frequency.seconds * 4.8).ago
    # Provides leeway for new stations
    if created_at > time_ago
      return false
    end

    observations.since(time_ago).order(created_at: :desc).count  < 3
  end

  def should_be_online?
    !should_be_offline?
  end

  def check_status!
    if should_be_offline?
      if online?
        event = events.create!(key: :offline)
        update_attribute(:online, false)
      end
    else # should be online
      if offline?
        event = events.create!(key: :online)
        update_attribute(:online, true)
      end
    end
    if event.present?
      event.notify
    end
  end

  def notify_online

  end

  def notify_offline

  end
end