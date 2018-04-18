class Band::ReleaseWorker < ApplicationWorker
  def perform(band, recording)
    Band::ReleaseRecording.(band: band, recording: recording)
    manager = GlobalID::Locator.locate(band).manager
    band_id = GlobalID::Locator.locate(band).id

    ActionCable.server.broadcast "activity_notifications:#{manager.id}", band:band_id, message:"<i class='fa fa-check-circle'></i> Activity done!</div>"
  end
end
