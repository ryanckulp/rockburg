class Band::PracticeWorker < ApplicationWorker
  def perform(band, hours)
    Band::Practice.(band: band, hours: hours)
  end
end