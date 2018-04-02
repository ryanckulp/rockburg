class ActivityWorker
  include Sidekiq::Worker

  def perform(band_id, activity, hours, song_id = nil)
    @band = Band.find_by_id(band_id)

    case activity
    when 'practice'
      @band.members.each do |member|
        increase_skill_amount = (rand(1..6) * hours.to_f/10).round
        member.increment!(:skill_primary_level, increase_skill_amount)
        @band.happenings.create(what: "#{member.name} increased their skill by #{increase_skill_amount} points!")

        increase_fatigue_amount = (rand(1..10) * hours.to_f/10).ceil
        member.increment!(:trait_fatigue, increase_fatigue_amount)
        @band.happenings.create(what: "#{member.name}'s fatigue increased by #{increase_fatigue_amount}")
      end
    when 'write_song'
      @band.members.each do |member|
        increase_fatigue_amount = rand(2..5) * hours
        member.increment!(:trait_fatigue, increase_fatigue_amount)
        @band.happenings.create(what: "#{member.name}'s fatigue increased by #{increase_fatigue_amount}")
      end

      skill_mp = 60
      creativity_mp = 25
      time_mp = 15
      ego_mp = 50
      member_multiplyer = @band.members.count * 100

      total_skills = @band.members.pluck(:skill_primary_level).inject(0, :+)
      total_creativity = @band.members.pluck(:trait_creativity).inject(0, :+)
      total_ego = @band.members.pluck(:trait_ego).inject(0, :+)

      possible_points = (member_multiplyer * skill_mp) + (member_multiplyer * creativity_mp) + (24 * time_mp)

      quality = 100

      points = (total_skills * skill_mp) + (total_creativity * creativity_mp) + (hours * time_mp)

      ego_weight = (total_ego * ego_mp).to_f / 10000
      total = quality * (points.to_f / possible_points.to_f)
      ego_reduction = total * ego_weight

      song_quality = (total - ego_reduction).round

      @song = Song.find_by_id(song_id)
      @song.update_attributes(quality: song_quality)
      @band.happenings.create(what: "#{@band.name} wrote a new song called #{@song.name}! It has a quality score of #{song_quality}.")
    when 'gig'
      @band.members.each do |member|
        increase_fatigue_amount = rand(5..15)
        member.increment!(:trait_fatigue, increase_fatigue_amount)
        @band.happenings.create(what: "#{member.name}'s fatigue increased by #{increase_fatigue_amount}")
      end
      gig = Gig.find_by_id(song_id)
      cap = gig.venue.capacity
      buzz = @band.buzz
      fans = @band.fans

      new_fans = ((buzz.to_f/cap.to_f) * 10).ceil
      new_fans = new_fans == 0 ? 2 : new_fans
      ticket_price = 10.0

      @band.increment!(:fans, new_fans)
      @band.increment!(:buzz, new_fans)

      revenue = new_fans * ticket_price

      @band.manager.financials.create!(amount: revenue, band_id: @band.id)

      gig.update_attributes(fans_gained: new_fans, money_made: revenue)

      @band.happenings.create(what: "You made #{revenue} at your gig!")
      @band.happenings.create(what: "You gained #{new_fans} new fans at your gig!")
    when 'record_single'
      @band.members.each do |member|
        increase_fatigue_amount = rand(10..25)
        member.increment!(:trait_fatigue, increase_fatigue_amount)
        @band.happenings.create(what: "#{member.name}'s fatigue increased by #{increase_fatigue_amount}")
      end

      @recording = Recording.find_by_id(song_id)
      studio = @recording.studio.cost
      song_avg = @recording.songs.average(:quality).to_i

      skill_mp = 60
      creativity_mp = 25
      ego_mp = 50
      member_multiplyer = @band.members.count * 100
      studio_mp = 80
      song_mp = 200

      total_skills = @band.members.pluck(:skill_primary_level).inject(0, :+)
      total_creativity = @band.members.pluck(:trait_creativity).inject(0, :+)
      total_ego = @band.members.pluck(:trait_ego).inject(0, :+)

      possible_points = (member_multiplyer * skill_mp) + (member_multiplyer * creativity_mp)  + (studio * studio_mp) + (song_avg * song_mp)

      quality = 100

      points = (total_skills * skill_mp) + (total_creativity * creativity_mp) + (studio * studio_mp) + (song_avg * song_mp)

      ego_weight = (total_ego * ego_mp).to_f / 10000
      total = quality * (points.to_f / possible_points.to_f)
      ego_reduction = total * ego_weight

      recording_quality = (total - ego_reduction).round

      @recording.update_attributes(quality: recording_quality)

      @band.manager.financials.create!(amount: -@recording.studio.cost, band_id: @band.id)

      @band.happenings.create(what: "#{@band.name} made a recording of #{@recording.songs.map { |s| s.name }.join ','}! It has a quality score of #{recording_quality} and cost #{@recording.studio.cost} to record.")
    when 'record_album'
      @band.members.each do |member|
        increase_fatigue_amount = rand(25..75)
        member.increment!(:trait_fatigue, increase_fatigue_amount)
        @band.happenings.create(what: "#{member.name}'s fatigue increased by #{increase_fatigue_amount}")
      end

      @recording = Recording.find_by_id(song_id)
      studio = @recording.studio.cost
      song_avg = @recording.songs.average(:quality).to_i

      skill_mp = 60
      creativity_mp = 25
      ego_mp = 50
      member_multiplyer = @band.members.count * 100
      studio_mp = 80
      song_mp = 200

      total_skills = @band.members.pluck(:skill_primary_level).inject(0, :+)
      total_creativity = @band.members.pluck(:trait_creativity).inject(0, :+)
      total_ego = @band.members.pluck(:trait_ego).inject(0, :+)

      possible_points = (member_multiplyer * skill_mp) + (member_multiplyer * creativity_mp)  + (studio * studio_mp) + (song_avg * song_mp)

      quality = 100

      points = (total_skills * skill_mp) + (total_creativity * creativity_mp) + (studio * studio_mp) + (song_avg * song_mp)

      ego_weight = (total_ego * ego_mp).to_f / 10000
      total = quality * (points.to_f / possible_points.to_f)
      ego_reduction = total * ego_weight

      recording_quality = (total - ego_reduction).round

      @recording.update_attributes(quality: recording_quality)

      @band.manager.financials.create!(amount: -@recording.studio.cost, band_id: @band.id)

      @band.happenings.create(what: "#{@band.name} recorded an album named #{@recording.name}! It has a quality score of #{recording_quality} and cost #{@recording.studio.cost} to record.")
    when 'release'
      recording = Recording.find_by_id(song_id)

      buzz = @band.buzz
      fans = @band.fans
      cap = recording.quality

      new_fans = ((buzz.to_f/cap.to_f) * 10).ceil
      new_fans = new_fans == 0 ? 2 : new_fans
      album_price = 10.0

      @band.increment!(:fans, new_fans)
      @band.increment!(:buzz, new_fans)

      revenue = new_fans * album_price

      @band.manager.financials.create!(amount: revenue, band_id: @band.id)

      recording.update_attributes(sales: revenue)

      @band.happenings.create(what: "You made #{revenue} from your release of #{recording.name}!")
      @band.happenings.create(what: "You gained #{new_fans} new fans from your release of #{recording.name}!")
    when 'rest'
      @band.members.each do |member|
        decrease_fatigue_amount = (rand(20..50) * hours.to_f/10).ceil
        member.decrement!(:trait_fatigue, decrease_fatigue_amount)
        @band.happenings.create(what: "#{member.name}'s fatigue decreased by #{decrease_fatigue_amount}")
      end
    end
  end
end
