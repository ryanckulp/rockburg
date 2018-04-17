class Band::RecordAlbumWorker < ApplicationWorker
  def perform(band, album)
    Band::RecordAlbum.(band: band, album: album)
  end
end