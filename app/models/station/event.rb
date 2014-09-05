# Station events should mark when stations go up / down, change ownership etc.
# They also notify station owners and throttle messages.
class Station::Event < ::Event
  belongs_to :station
  scope :since, ->(time_ago){ where(:created_at.gte => time_ago) }
  attr_internal :event_type

  @@PRESETS = {
      online: {
          level: :info,
          body: "%{name} is online",
      },
      offline: {
          level: :warning,
          body: "%{name} is offline",
          #cooldown: 1.day

      },
      low_balance: {
          level: :warning,
          body: "%{name} has a low balance",
          cooldown: 3.hours # wait this long before notifying user of this event again
      }
  }

  validates_inclusion_of :key, in: @@PRESETS.keys

  after_create do |doc|
    doc.event_type = @@PRESETS[key]
  end

  # Test if this event can send messages
  # @return [Boolean]
  def can_notify?
    if notified?
      false
    else
      if event_type[:cooldown]
        station.events.where(key: key, notified: true)
          .since(event_type[:cooldown].ago).length == 0
      else
        true
      end
    end
  end

  # Notify station owners of an event.
  # @return [Array, Nil]
  def notify
    if (can_notify?)
      update_attribute(:notified, true)
      station.owners.all.map do |owner|
        message = messages.create(
            level: event_type[:level],
            recipient: owner,
            body: event_type[:body] % station.attributes.symbolize_keys,
            mailer: StationMailer
        )
        message.send_mail!
        message
      end
    end
  end
end