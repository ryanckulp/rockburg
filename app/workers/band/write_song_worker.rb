class Band::WriteSongWorker < ApplicationWorker
  def perform(band, hours)
    Band::WriteSong.(band: band, hours: hours)
  end
end