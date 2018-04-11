class Skill < ApplicationRecord
  has_many :genre_skills
  has_many :genres, through: :genre_skills
  has_many :member_skills
  has_many :members, through: :member_skills

  def to_param
    [id, name.parameterize].join("-")
  end
end
