class ActivityWorker
  include Sidekiq::Worker

  def perform(band_id, activity, hours, song_id = nil)
    @band = Band.find_by_id(band_id)

    case activity
    when 'practice'
      Band::Practice.(band: @band, hours: hours)
    when 'write_song'
      Band::WriteSong.(band: @band, hours: hours)
    when 'gig'
      Band::AddFatigue.(band: @band, range: 5..15)

      gig = Gig.find_by_id(song_id)
      cap = gig.venue.capacity.to_f
      buzz = @band.buzz.to_f
      fans = @band.fans.to_f

      # new_fans = ((buzz.to_f/cap.to_f) * 10).ceil
      # new_fans = new_fans.zero? ? 2 : new_fans

      # new_fans = fans**(buzz / 125)
      # cap_deduction = (cap - new_fans) / 10
      # total_new = new_fans - cap_deduction
      # final_new = total_new <= 0 ? 2 : total_new

      attendance = ((fans * rand(0.05..0.3)) + ((buzz / 100) * cap)).ceil
      attendance = attendance.zero? ? rand(1..3) : attendance

      new_fans = new_fans = (((attendance / cap)**rand(1..3.5)) * 100).ceil
      new_fans = new_fans.zero? ? rand(1..3) : new_fans

      new_buzz = (((attendance / cap)**rand(1..2.5)) * 100).ceil
      new_buzz = new_buzz.zero? ? rand(1..3) : new_buzz

      ticket_price = 10.0

      @band.increment!(:fans, new_fans)
      @band.increment!(:buzz, new_buzz)

      revenue = attendance * ticket_price

      Band::EarnMoney.(amount: revenue, band: @band)

      gig.update_attributes(fans_gained: new_fans, money_made: revenue)

      @band.happenings.create(what: "You made §#{revenue.to_i} from #{attendance.to_i} people at your gig!")
      @band.happenings.create(what: "You gained #{new_fans} new fans and #{new_buzz} buzz at your gig!")
    when 'record_single'
      Band::AddFatigue.(band: @band, range: 10..25)

      @recording = Recording.find_by_id(song_id)
      studio = @recording.studio.weight
      song_avg = @recording.songs.average(:quality).to_i

      song_mp = 40
      studio_mp = 30
      skill_mp = 20
      creativity_mp = 5
      ego_mp = 5
      member_multiplyer = @band.members.count * 100

      total_skills = @band.members.pluck(:skill_primary_level).inject(0, :+)
      total_creativity = @band.members.pluck(:trait_creativity).inject(0, :+)
      total_ego = @band.members.pluck(:trait_ego).inject(0, :+)

      possible_points = (member_multiplyer * skill_mp) + (member_multiplyer * creativity_mp) + (Studio.order(:weight).last.weight * studio_mp) + (100 * song_mp)

      quality = 100

      points = (total_skills * skill_mp) + (total_creativity * creativity_mp) + (studio * studio_mp) + (song_avg * song_mp)

      ego_weight = (total_ego * ego_mp).to_f / possible_points.to_f
      total = quality * (points.to_f / possible_points.to_f)
      ego_reduction = total * ego_weight

      recording_quality = (total - ego_reduction).round

      @recording.update_attributes(quality: recording_quality)

      Band::SpendMoney.(band: @band, amount: @recording.studio.cost)

      @band.happenings.create(what: "#{@band.name} made a recording of #{@recording.songs.map(&:name).join ','}! It has a quality score of #{recording_quality} and cost §#{@recording.studio.cost} to record.")
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

      total_skills = @band.members.pluck(:skill_primary_level).inject(0, :+)
      total_creativity = @band.members.pluck(:trait_creativity).inject(0, :+)
      total_ego = @band.members.pluck(:trait_ego).inject(0, :+)

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

      buzz = @band.buzz
      fans = @band.fans
      quality = recording.quality

      streaming_rate = 0.03
      streams = (fans + (fans * (buzz / 100))) * (quality / 100)

      earnings = (streaming_rate * streaming_rate).ceil

      Band::EarnMoney.(band: @band, amount: earnings)

      recording.update_attributes(sales: earnings)

      @band.happenings.create(what: "You made §#{earnings.to_i} from your release of #{recording.name}!")
    when 'rest'
      @band.members.each do |member|
        decrease_fatigue_amount = (rand(20..50) * hours.to_f / 10).ceil
        member.decrement!(:trait_fatigue, decrease_fatigue_amount)
        @band.happenings.create(what: "#{member.name}'s fatigue decreased by #{decrease_fatigue_amount}")
      end
    end
  end
end
