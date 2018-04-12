class Member < ApplicationRecord
  belongs_to :primary_skill, class_name: 'Skill', foreign_key: :skill_primary
  belongs_to :secondary_skill, class_name: 'Skill', foreign_key: :skill_secondary, optional: true
  belongs_to :tertiary_skill, class_name: 'Skill', foreign_key: :skill_tertiary, optional: true
  has_many :member_bands
  has_many :bands, through: :member_bands

  def age
    now = Time.now.utc.to_date
    now.year - birthdate.year - ((now.month > birthdate.month || (now.month == birthdate.month && now.day >= birthdate.day)) ? 0 : 1)
  end

  def cost_generator
    # NOTE: placeholder until all calls to member.cost_generator can be replaced with Member::CostGenerator.(member: m).result
    Member::CostGenerator.(member: self).result
  end

  def avatar_url
    # NOTE: placeholder until all calls to member.cost_generator can be replaced with Member::AvatarURL.(member: m).result
    Member::AvatarURL.(member: self).result
  end
end
