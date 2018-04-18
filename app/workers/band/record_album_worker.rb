class Band::RecordAlbumWorker < ApplicationWorker
  def perform(band, album)
    Band::RecordAlbum.(band: band, album: album)
    manager = GlobalID::Locator.locate(band).manager
    band_id = GlobalID::Locator.locate(band).id

    ActionCable.server.broadcast "activity_notifications:#{manager.id}", band:band_id, message:"<i class='fa fa-check-circle'></i> Activity done!</div>"
  end
end
