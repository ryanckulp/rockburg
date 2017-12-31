class Recording < ApplicationRecord
  has_many :song_recordings
  has_many :songs, through: :song_recordings
end
