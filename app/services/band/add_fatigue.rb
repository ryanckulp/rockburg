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

      if member.trait_fatigue + increase_fatigue_amount > 100
        member.trait_fatigue = 100
        increased_by = "is maxed out at 100"
      else
        member.trait_fatigue += increase_fatigue_amount
        increased_by = "increased by #{increase_fatigue_amount}"
      end

      member.save

      band.happenings.create(what: "#{member.name}'s fatigue #{increased_by}", kind: 'fatigue_increase')
    end
  end
end
