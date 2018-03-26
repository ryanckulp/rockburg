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

      @band.increment!(:fans, new_fans)
      @band.increment!(:buzz, new_fans)
      gig.update_attributes(fans_gained: new_fans)
      @band.happenings.create(what: "You gained #{new_fans} new fans at your gig!")
    when 'record_single'

    end
  end
end
