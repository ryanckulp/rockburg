class Band::Practice < ApplicationService
  expects do
    required(:band).filled
    required(:hours).filled.value(type?: Integer)
  end

  delegate :band, :hours, to: :context

  before do
    context.band = Band.ensure(band)
    context.fail!(message: "Hours must be positive") unless hours.positive?
  end

  def call
    band.members.each do |member|
      result = Member::Practice.(member: member, hours: hours)
      if result.success?
        band.happenings.create(what: "#{member.name}'s fatigue increased by #{result.fatigue_change}")
        band.happenings.create(what: "#{member.name}'s skill increased by #{result.skill_change}")
      end
    end
  end
end
