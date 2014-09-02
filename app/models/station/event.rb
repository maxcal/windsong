# Used to log and notifity events such as a station going offline
class Station::Event < Event
  belongs_to :station

  @@EVENT_TYPES = {
    online: {
        level: :info,
        message: "%{name} is online",
    },
    offline: {
        level: :warning,
        message: "%{name} is offline"

    }
  }

  validates_inclusion_of :key, in: @@EVENT_TYPES.keys

  # Notify station owners of an event.
  def notify
    event_type = @@EVENT_TYPES[key]
    station.owners.all.map do |owner|
      note = notifications.create(event_type.merge({
          recipient: owner,
          message: event_type[:message] % station.attributes.symbolize_keys,
          mailer: StationMailer
      }))
      note.send_mail!
      note
    end
  end
end