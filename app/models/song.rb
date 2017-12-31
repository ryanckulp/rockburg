class Song < ApplicationRecord
  belongs_to :band
  has_many :song_recordings
  has_many :recordings, through: :song_recordings
end
