class Recording < ApplicationRecord
  belongs_to :band
  belongs_to :studio
  has_many :song_recordings
  has_many :songs, through: :song_recordings
end
