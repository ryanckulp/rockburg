class ActivityWorker
  include Sidekiq::Worker

  def perform(band_id, activity, hours)
    @band = Band.find_by_id(band_id)

    case activity
    when 'practice'
      @band.members.each do |member|
        increase_skill_amount = rand(0..2) * hours
        member.increment!(:skill_primary_level, increase_skill_amount)
        @band.happenings.create(what: "#{member.name} increased their skill by #{increase_skill_amount} points!")

        increase_fatigue_amount = rand(1..5) * hours
        member.increment!(:trait_fatigue, increase_fatigue_amount)
        @band.happenings.create(what: "#{member.name}'s fatigue increased by #{increase_fatigue_amount}")
      end
    end
  end
end
