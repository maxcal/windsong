class StationMailer < ActionMailer::Base
  default from: "from@example.com"

  attr_accessor :user
  attr_internal :event

  # @param [User] user
  # @param [Event] event
  # @return [Mail]
  def online(user, event)
    @station = event.station
    message = mail(
        to: user.email,
        subject: "#{event.station.name} has started to respond."
    ) do |format|
      format.text
    end
    deliver_and_log("online", message)
  end

  # @param [User] user
  # @param [Event] event
  # @return [Mail]
  def offline(user, event)
    @station = event.station
    message = mail(
        to: user.email,
        subject: "#{event.station.name} has not responded in a while."
    ) do |format|
      format.text
    end
    deliver_and_log("offline", message)
  end

  # @param [User] user
  # @param [Event] event
  # @return [Mail]
  def low_balance(user, event)
    @station = event.station
    message = mail(
        to: user.email,
        subject: "#{event.station.name} has a low balance."
    ) do |format|
      format.text
    end
    deliver_and_log("low_balance", message)
  end

  # @param station Station
  # @param options Hash
  # @return Mail::Message | nil returns nil if mail could not be created
  private def deliver_and_log(meth, message)
    if message
      unless message.deliver
        Rails.logger.error("StationMailer.#{meth}: Mail could not be delivered")
      end
      return message
    else
      Rails.logger.error("StationMailer.#{meth}: Mail could not be created")
    end
    nil
  end
end