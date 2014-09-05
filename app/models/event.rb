# The event class is used to register and track significant events in the application
# @note This class is meant to be sub-classed for more specific event types
class Event
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  # @!attribute [r] key
  #   @return [Symbol]
  #     A unique key for the event type
  field :key, type: Symbol
  # @!attribute [r] meta
  #   @return [String]
  #   Extra information to attach to event
  field :meta, type: String
  # @!attribute
  #   @return [Boolean]
  #   Have listeners been notified of this event?
  field :notified, type: Boolean
  # @!attribute
  #   @return [Mongoid::Relations]
  has_many :notifications
  attr_readonly :key, :meta
end