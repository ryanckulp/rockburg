class ActivityWorker
  include Sidekiq::Worker

  def perform(band_id, activity, hours, song_id = nil)
    @band = Band.ensure!(band_id)

    case activity
    when 'release'
      recording = Recording.find_by_id(song_id)
      recording.update_attribute(:release_at, Time.now)

      STREAMING_RATE = 0.03
      earnings = (recording.calc_streams * STREAMING_RATE).ceil

      Band::EarnMoney.(band: @band, amount: earnings)

      recording.update_attributes(sales: earnings)

      @band.happenings.create(what: "You made §#{earnings.to_i} from your release of #{recording.name}!")
    when 'rest'
      Band::RemoveFatigue.(band: @band, hours: hours)
    else
      Rails.logger.debug "ActivityWorker no longer processes: #{activity}".yellow
    end
  end

  def pluralize number, text
    return "#{number} #{text.pluralize}" if number != 1
    "#{number} #{text}"
  end
end
