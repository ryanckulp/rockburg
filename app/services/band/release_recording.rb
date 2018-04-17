class Band::ReleaseRecording < ApplicationService
  include ActionView::Helpers::NumberHelper
  include ApplicationHelper

  expects do
    required(:band).filled
    required(:recording).filled
  end

  delegate :band, :recording, to: :context

  before do
    context.band = Band.ensure!(band)
    context.recording = band.recordings.ensure!(recording)
  end

  STREAMING_RATE = 0.03
  def call
    recording.transaction do
      recording.release_at = Time.current

      recording.sales = (STREAMING_RATE * recording.calc_streams).ceil
      recording.save!

      Band::EarnMoney.(band: band, amount: recording.sales)

      band.happenings.create(what: "You made #{as_game_currency(recording.sales.to_i)} from your release of #{recording.name}!")
    end
  end
end
