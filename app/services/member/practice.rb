class Member::Practice < ApplicationService
  # include Wisper::Publisher

  expects do
    required(:member).filled
    required(:hours).filled
  end

  delegate :member, :hours, to: :context

  before do
    context.member = Member.ensure(member)
    # self.subscribe(Band::Subscriber.new)
  end

  def call
    increase_skill = (rand(1..6) * hours.to_f / 5).ceil
    increase_fatigue = (rand(1..10) * hours.to_f / 5).ceil
    Member.transaction do
      context.skill_change = increase_skill
      context.fatigue_change = increase_fatigue

      member.skill_primary_level += increase_skill
      member.trait_fatigue += increase_fatigue
      member.save!

      # broadcast(:stat_change, {stat: :skill_primary_level, member: member.to_global_id, change: increase_skill})
      # broadcast(:stat_change, {stat: :trait_fatigue, member: member.to_global_id, change: increase_fatigue})
    end
  end
end
