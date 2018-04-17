class Activity::ReleaseRecording < ApplicationService
  expects do
    required(:band).filled
    required(:recording).filled
    optional(:hours)
  end

  delegate :band, :recording, :hours, to: :context

  before do
    context.band = Band.ensure(band)
    context.recording = band.recordings.ensure(recording)
    context.hours = (hours || 24).to_i
    context.fail! unless hours.positive?
  end

  def call
    start_at = Time.current
    end_at = start_at + hours.seconds
    context.activity = Activity.create!(band: band, action: :release, starts_at: start_at, ends_at: end_at)
    Band::ReleaseWorker.perform_at(end_at, band.to_global_id, recording.to_global_id)
  end
end
