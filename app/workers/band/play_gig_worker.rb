class Band::PlayGigWorker < ApplicationWorker
  def perform(band, gig, hours)
    Band::PlayGig.(band: band, gig: gig, hours: hours)
    manager = GlobalID::Locator.locate(band).manager
    band_id = GlobalID::Locator.locate(band).id

    ActionCable.server.broadcast "activity_notifications:#{manager.id}", band:band_id, message:"<i class='fa fa-check-circle'></i> Activity done!</div>"
  end
end
