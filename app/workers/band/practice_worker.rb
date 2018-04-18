class Band::PracticeWorker < ApplicationWorker
  def perform(band, hours)
    Band::Practice.(band: band, hours: hours)
    manager = GlobalID::Locator.locate(band).manager
    #ActionCable.server.broadcast 'activity_notifications_channel', message: 'Done!'

     ActionCable.server.broadcast "activity_notifications:1", message:"<div class='alert alert-warning alert-block text-center'><i class='fa fa-circle-o-notch fa-spin'></i>We did it!</div>"
  end
end
