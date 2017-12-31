class CreateSongRecordings < ActiveRecord::Migration[5.1]
  def change
    create_table :song_recordings do |t|
      t.belongs_to :recording, index: true
      t.belongs_to :song, index: true
      t.timestamps
    end
  end
end
