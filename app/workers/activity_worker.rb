class ActivityWorker
  include Sidekiq::Worker

  def perform(band_id, activity, hours, song_id = nil)
    @band = Band.ensure!(band_id)

    case activity
    when 'practice'
      Band::Practice.(band: @band, hours: hours)
    when 'write_song'
      Band::WriteSong.(band: @band, hours: hours)
    when 'gig'
      Band::PlayGig.(band: @band, hours: hours, gig: song_id)
    when 'record_single'
      Band::RecordSingle(band: @band, recording: song_id, hours: hours)

    when 'record_album'
      Band::AddFatigue.(band: @band, range: 25..75)

      @recording = Recording.find_by_id(song_id)
      studio = @recording.studio.cost
      song_avg = @recording.songs.average(:quality).to_i

      song_mp = 40
      studio_mp = 30
      skill_mp = 20
      creativity_mp = 5
      ego_mp = 5
      member_multiplyer = @band.members.count * 100

      total_skills = @band.members.sum(:skill_primary_level).to_i
      total_creativity = @band.members.sum(:trait_creativity).to_i
      total_ego = @band.members.sum(:trait_ego).to_i

      possible_points = (member_multiplyer * skill_mp) + (member_multiplyer * creativity_mp) + (studio * studio_mp) + (song_avg * song_mp)

      quality = 100

      points = (total_skills * skill_mp) + (total_creativity * creativity_mp) + (studio * studio_mp) + (song_avg * song_mp)

      ego_weight = (total_ego * ego_mp).to_f / possible_points.to_f
      total = quality * (points.to_f / possible_points.to_f)
      ego_reduction = total * ego_weight

      recording_quality = (total - ego_reduction).round

      @recording.update_attributes(quality: recording_quality)

      Band::SpendMoney.(band: @band, amount: @recording.studio.cost)

      @band.happenings.create(what: "#{@band.name} recorded an album named #{@recording.name}! It has a quality score of #{recording_quality} and cost §#{@recording.studio.cost} to record.")
    when 'release'
      recording = Recording.find_by_id(song_id)
      recording.update_attribute(:release_at, Time.now)

      STREAMING_RATE = 0.03
      streams = recording.calc_streams

      earnings = (streams * STREAMING_RATE).ceil

      Band::EarnMoney.(band: @band, amount: earnings)

      recording.update_attributes(sales: earnings)

      @band.happenings.create(what: "You made §#{earnings.to_i} from your release of #{recording.name}!")
    when 'rest'
      Band::RemoveFatigue.(band: @band, hours: hours)
    end
  end

  def pluralize number, text
    return "#{number} #{text.pluralize}" if number != 1
    "#{number} #{text}"
  end
end
