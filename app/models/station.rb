class Station
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  include Presentable

  # Relations
  # @!attribute [rw] latest_observation
  #    @return [Location]
  embeds_one :location
  # @!attribute [rw] observations
  #   @return [Mongoid::Relations]
  has_many :observations
  # @!attribute [rw] latest_observation
  #    @return [Observation]
  embeds_one :latest_observation, class_name: 'Observation'
  # @!attribute [rw] events
  #    @return [Event]
  has_many :events, class_name: 'Station::Event'
  # @!attribute [rw] owners
  #    @return [Mongoid::Relations]
  has_and_belongs_to_many :owners, class_name: 'User',
                          inverse_of: :stations
  # @!attribute [rw] name
  #   @return [String]
  field :name, type: String
  # @!attribute [rw] hardware_uid
  #   @return [String]
  #   A unique hardware ID such as an IMEI number. Used by stations to lookup their ID.
  field :hardware_uid, type: String
  # @!attribute [rw] custom_slug
  #   @return [String]
  field :custom_slug, type: String
  # @!attribute [rw] online
  #   @return [Boolean]
  #   Is this station responsive - do we have up to date observations?
  field :online, type: Boolean
  # @!attribute [rw] update_frequency
  #   @return [Integer]
  #   How often station should receive new observations in seconds
  field :update_frequency, type: Integer, default: 5.minutes.seconds
  # @!attribute [rw] balance
  #   @return [Float]
  #   The balance on a prepaid SIM card - may be zero if fixed rate
  field :balance, type: Float
  # @!attribute [rw] low_balance_threshold
  #   @return [Float]
  #   Notify owner when balance drops below this threshold
  #   @note set to zero for a fixed rate or monthly subscription
  field :low_balance_threshold, type: Float, default: 15
  # @!attribute slug [rw]
  #   @return [String]
  #   Used in addition to ID for URLs
  slug :custom_slug, reserved: %w[find, station, stations, observations, new]

  validates_presence_of :name, :hardware_uid
  validates_uniqueness_of :hardware_uid

  # Slug name if no custom_slug
  before_validation do |doc|
    if doc.custom_slug.blank?
      doc.custom_slug = name
    end
  end

  # @return [Boolean]
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

  # The inverse of should_be_offline?
  # Why? Readability...
  # @return [Boolean]
  def should_be_online?
    !should_be_offline?
  end

  # Check station status and send messages if it is unresponsive or has a low balance
  #   @return [Mongoid::Relations] any events created
  def check_status!
    events
    if should_be_offline?
      if online?
        events.create!(key: :offline).notify
        update_attribute(:online, false)
      end
    else # should be online
      if offline?
        events.create!(key: :online).notify
        update_attribute(:online, true)
      end
    end
    if low_balance?
      events.create!(key: :low_balance).notify if online?
    end
  end

  # Check if station balance is low
  #   @return [Boolean]
  def low_balance?
    balance < low_balance_threshold
  end

end