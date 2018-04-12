# == Schema Information
#
# Table name: genre_skills
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  genre_id   :bigint(8)
#  skill_id   :bigint(8)
#
# Indexes
#
#  index_genre_skills_on_genre_id  (genre_id)
#  index_genre_skills_on_skill_id  (skill_id)
#

class GenreSkill < ApplicationRecord
  belongs_to :genre
  belongs_to :skill
end
