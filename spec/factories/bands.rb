# == Schema Information
#
# Table name: bands
#
#  id         :bigint(8)        not null, primary key
#  buzz       :integer          default(0)
#  fans       :integer          default(0)
#  name       :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  genre_id   :bigint(8)
#  manager_id :bigint(8)
#
# Indexes
#
#  index_bands_on_genre_id    (genre_id)
#  index_bands_on_manager_id  (manager_id)
#
# Foreign Keys
#
#  fk_rails_...  (genre_id => genres.id)
#

FactoryBot.define do
  factory :band do
    name { Generators::BandName.call.result }
    manager
    genre     { Genre.all.sample }
    fans      { rand(0..500) }
    buzz      { rand(0..500) }
  end
end
