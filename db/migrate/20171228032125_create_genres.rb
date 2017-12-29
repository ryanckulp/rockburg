class CreateGenres < ActiveRecord::Migration[5.1]
  def change
    create_table :genres do |t|
      t.string :name
      t.string :style
      t.integer :min_members
      t.integer :max_members

      t.timestamps
    end
  end
end
