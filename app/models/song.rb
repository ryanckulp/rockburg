# == Schema Information
#
# Table name: songs
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  quality    :integer          default(0)
#  status     :string           default("writing")
#  streams    :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  band_id    :bigint(8)
#
# Indexes
#
#  index_songs_on_band_id  (band_id)
#

class Song < ApplicationRecord
  belongs_to :band
  has_many :song_recordings
  has_many :recordings, through: :song_recordings
end
