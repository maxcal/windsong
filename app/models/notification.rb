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

  field :key, type: Symbol
  field :meta
  field :level, type: Symbol, default: :info
  field :message, type: String
  field :read, type: Boolean, default: false
  field :sent, type: Boolean, default: false

  attr_accessor :mailer

  belongs_to :recipient, class_name: "User"
  belongs_to :event, class_name: "Event"

  validates_inclusion_of :level, in: @@LEVELS_RFC_5424.keys, allow_blank: true

  def new(attrs = nil)
    @mailer ||= attrs[:mailer]
    super
  end

  # @param [Symbol, Integer] value
  def level=(value)
    unless value.is_a?(Symbol)
      value = @@LEVELS_RFC_5424.key(value)
    end
    super(value)
  end

  # @return [Mail, Nil]
  def send_mail!
    @mailer.send(event.key, recipient, event)
  end
end