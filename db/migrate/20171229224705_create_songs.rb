class CreateSongs < ActiveRecord::Migration[5.1]
  def change
    create_table :songs do |t|
      t.references :band
      t.string :name
      t.integer :quality, default: 0
      t.integer :streams, default: 0
      t.string :status, default: 'writing'
      t.timestamps
    end
  end
end
