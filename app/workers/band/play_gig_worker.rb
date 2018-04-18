class Band::PlayGigWorker < ApplicationWorker
  def perform(band, gig, hours)
    Band::PlayGig.(band: band, gig: gig, hours: hours)

    band = Band.ensure(band)

    ActionCable.server.broadcast "activity_notifications:#{band.manager_id}",
      band: band.id,
      message: "<i class='fa fa-check-circle'></i> Activity done!</div>"
  end
end
