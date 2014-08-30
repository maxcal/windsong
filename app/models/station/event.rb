# Used to log and notifity events such as a station going offline
class Station::Event < Event
  belongs_to :station

  @@EVENTS = {
    online: {},
    offline: {}
  }

  # Notify listeners of an event.
  def notify

  end
end