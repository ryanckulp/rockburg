class CreateGameData < ActiveRecord::Migration[5.2]
  def change
    create_table :game_data do |t|
      t.string :key
      t.jsonb :value

      t.timestamps
    end
    add_index :game_data, :key, unique: true
  end
end
