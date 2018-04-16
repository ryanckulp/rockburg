class Band::PlayGigWorker < ApplicationWorker
  def perform(band, gig, hours)
    Band::PlayGig.(band: band, gig: gig, hours: hours)
  end
end