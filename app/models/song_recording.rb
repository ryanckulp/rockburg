# == Schema Information
#
# Table name: song_recordings
#
#  id           :bigint(8)        not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  recording_id :bigint(8)
#  song_id      :bigint(8)
#
# Indexes
#
#  index_song_recordings_on_recording_id  (recording_id)
#  index_song_recordings_on_song_id       (song_id)
#

class SongRecording < ApplicationRecord
  belongs_to :song
  belongs_to :recording
end
