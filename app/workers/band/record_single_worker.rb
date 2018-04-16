class Band::RecordSingleWorker < ApplicationWorker
  def perform(band, recording, hours = nil)
    Band::RecordSingle.(band: band, recording: recording, hours: hours)
  end
end