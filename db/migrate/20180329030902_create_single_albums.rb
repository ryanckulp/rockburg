class CreateSingleAlbums < ActiveRecord::Migration[5.1]
  def change
    create_table :single_albums do |t|
      t.integer :album_id
      t.integer :single_id
      t.timestamps
    end
  end
end
