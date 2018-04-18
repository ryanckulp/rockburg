class ActivityNotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "activity_notifications:#{current_manager.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
