# == Schema Information
#
# Table name: skills
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  verb       :string           default("play")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Skill < ApplicationRecord
  ensure_by :id, :name

  has_many :genre_skills
  has_many :genres, through: :genre_skills
  has_many :member_skills
  has_many :members, through: :member_skills

  def to_param
    [id, name.parameterize].join("-")
  end
end
