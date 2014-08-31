class Notification
  include Mongoid::Document

  # 8 log levels according to RFC 5424 (http://tools.ietf.org/html/rfc5424)
  # Used for thresholding
  @@LEVELS_RFC_5424 = {
      debug:  100 ,    # Detailed debug information.
      info:   200,     # Interesting events. Examples: User logs in, SQL logs.
      notice: 250,   # Normal but significant events.
      warning: 300,  # Exceptional occurrences that are not errors. Undesirable things that are not necessarily wrong.
      error:  400,    # Runtime errors that do not require immediate action but should typically be logged and monitored.
      critical: 500, # Critical conditions. Example: Application component unavailable, unexpected exception.
      alert: 550,    # Action must be taken immediately. Example: Entire website down, database unavailable, etc.
      emergency: 600 # Emergency: system is unusable.
  }

  field :level, type: Symbol, default: :info
  field :message, type: String
  field :notified, type: Boolean, default: false
  belongs_to :recipient, class_name: "User"
  has_one :event, class_name: "Event"

  validates_inclusion_of :level, in: @@LEVELS_RFC_5424.keys, allow_blank: true

  # @param [Symbol, Integer] value
  def level=(value)
    unless value.is_a?(Symbol)
      value = @@LEVELS_RFC_5424.key(value)
    end
    super(value)
  end

end