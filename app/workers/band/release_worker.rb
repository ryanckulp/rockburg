class Band::ReleaseWorker < ApplicationWorker
  def perform(band, recording)
    Band::ReleaseRecording.(band: band, recording: recording)
  end
end