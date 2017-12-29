class Genre < ApplicationRecord
  include ActionView::Helpers::TextHelper
  validates :name, uniqueness: { scope: :style }
  has_many :bands
  has_many :genre_skills
  has_many :skills, through: :genre_skills

  def full_genre
    "#{name} - #{style} (#{pluralize(min_members, 'member')})"
  end
end
