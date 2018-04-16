class Band::RestWorker < ApplicationWorker
  def perform(band, hours)
    Band::RemoveFatigue.(band: band, hours: hours)
  end
end