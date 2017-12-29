class Member < ApplicationRecord
  belongs_to :skill_primary, class_name: 'Skill', foreign_key: :skill_primary
  belongs_to :skill_secondary, class_name: 'Skill', foreign_key: :skill_secondary, optional: true
  belongs_to :skill_tertiary, class_name: 'Skill', foreign_key: :skill_tertiary, optional: true
  has_many :member_bands
  has_many :bands, through: :member_bands

  def age
    now = Time.now.utc.to_date
    now.year - birthdate.year - ((now.month > birthdate.month || (now.month == birthdate.month && now.day >= birthdate.day)) ? 0 : 1)
  end

  def avatar
    "http://api.adorable.io/avatar/500/#{self.id}-#{self.name.parameterize}-#{self.created_at}"
  end

  def cost_generator
    skill_mp = 60
    creativity_mp = 25
    looks_mp = 15
    ego_mp = 50
    #network_mp = 30
    #drive_mp = 0.5
    #stamina_mp = 0.5
    #productivity_mp = 0.5
    #aptitude_mp = 0.8

    #possible_points = (100 * skill_mp) + (100 * network_mp) + (100 * creativity_mp) + (100 * drive_mp) + (100 * stamina_mp) + (100 * looks_mp) + (100 * productivity_mp) + (100 * aptitude_mp) - (100 * ego_mp)
    possible_points = (100 * skill_mp) + (100 * creativity_mp) + (100 * looks_mp)

    high_salary = 5000

    points = skill_primary_level * skill_mp +
      trait_creativity * creativity_mp +
      trait_looks * looks_mp
    #trait_network * network_mp +
    #trait_drive * drive_mp +
    #trait_stamina * stamina_mp +
    #trait_productivity * productivity_mp +
    #trait_aptitude * aptitude_mp -

    ego_weight = (trait_ego * ego_mp).to_f / 10000
    full_salary = high_salary * (points.to_f / possible_points.to_f)
    ego_reduction = full_salary * ego_weight

    full_salary - ego_reduction
  end
end
