class Band::PracticeWorker < ApplicationWorker
  def perform(band, hours)
    band = Band.ensure(band)
    hours = hours.to_i

    Band::RemoveFatigue.(band: band, hours: hours)
  end
end