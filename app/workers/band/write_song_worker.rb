class Band::WriteSongWorker < ApplicationWorker
  def perform(band, hours)
    band = Band.ensure(band)
    hours = hours.to_i

    Band::WriteSong.(band: band, hours: hours)
  end
end