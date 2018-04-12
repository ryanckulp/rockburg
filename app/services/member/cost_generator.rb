class Member
  class CostGenerator < ApplicationService
    expects do
      required(:member).filled
    end

    delegate :member, to: :context

    before do
      context.member = Member.ensure(member)
    end

    def call
      skill_mp = 60
      creativity_mp = 25
      looks_mp = 15
      ego_mp = 50
      # network_mp = 30
      # drive_mp = 0.5
      # stamina_mp = 0.5
      # productivity_mp = 0.5
      # aptitude_mp = 0.8

      # possible_points = (100 * skill_mp) + (100 * network_mp) + (100 * creativity_mp) + (100 * drive_mp) + (100 * stamina_mp) + (100 * looks_mp) + (100 * productivity_mp) + (100 * aptitude_mp) - (100 * ego_mp)
      possible_points = (100 * skill_mp) + (100 * creativity_mp) + (100 * looks_mp)

      high_salary = 500

      points = member.skill_primary_level * skill_mp +
               member.trait_creativity * creativity_mp +
               member.trait_looks * looks_mp
      # trait_network * network_mp +
      # trait_drive * drive_mp +
      # trait_stamina * stamina_mp +
      # trait_productivity * productivity_mp +
      # trait_aptitude * aptitude_mp -

      ego_weight = (member.trait_ego * ego_mp).to_f / 10_000
      full_salary = high_salary * (points.to_f / possible_points.to_f)
      ego_reduction = full_salary * ego_weight

      context.result = (full_salary - ego_reduction).round
    end
  end
end