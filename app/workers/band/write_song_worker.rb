class Band::WriteSongWorker < ApplicationWorker
  def perform(band)
    Band::WriteSong.(band: band)
  end
end