class Band::WriteSong < ApplicationService
  expects do
    required(:band).filled
  end

  delegate :band, to: :context

  before do
    context.band = Band.ensure(band)
  end

  def call
    context.song = Song.create(band: band, name: Generator.song_title)
  end
end