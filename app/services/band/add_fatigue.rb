class Band::AddFatigue < ApplicationService
  expects do
    required(:band).filled
    required(:range).filled
  end

  delegate :band, :range, to: :context

  before do
    context.band = Band.ensure(band)
  end

  def call
    band.members.each do |member|
      increase_fatigue_amount = rand(range)
      member.increment!(:trait_fatigue, increase_fatigue_amount)
      band.happenings.create(what: "#{member.name}'s fatigue increased by #{increase_fatigue_amount}")
    end
  end
end