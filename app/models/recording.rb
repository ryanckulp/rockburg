class Recording < ApplicationRecord
  belongs_to :band
  belongs_to :studio
  has_many :song_recordings
  has_many :songs, through: :song_recordings
  has_many :single_albums, :foreign_key => :album_id
  has_many :singles, through: :single_albums, :source => :recording
end
