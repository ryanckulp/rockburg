class Recording::CalcEarnings < ApplicationService

  expects do
    required(:recording).filled
  end

  delegate :recording, to: :context

  before do
    context.recording = Recording.ensure!(recording)
  end

  def call
    band = recording.band
    days_since_release = (Date.today - recording.release_at.to_date).to_i
    streams = (band.fans + (band.fans * (band.buzz / 100.0))) * (recording.quality / 100.0) - (band.fans * (days_since_release * 0.05))

    context.earnings = (streams * ::STREAMING_RATE)
  end

end
