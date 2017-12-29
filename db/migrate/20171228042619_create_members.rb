class CreateMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :members do |t|
      t.string :name, default: ""
      t.string :gender, default: ""
      t.date :birthdate
      t.integer :cost, default: 0, null: false
      t.integer :trait_stamina, default: 0, null: false
      t.integer :trait_ego, default: 0, null: false
      t.integer :trait_looks, default: 0, null: false
      t.integer :trait_drive, default: 0, null: false
      t.integer :trait_productivity, default: 0, null: false
      t.integer :trait_aptitude, default: 0, null: false
      t.integer :trait_creativity, default: 0, null: false
      t.integer :trait_network, default: 0, null: false
      t.integer :trait_fatigue, default: 0, null: false
      t.integer :skill_primary
      t.integer :skill_primary_level, default: 0
      t.integer :skill_secondary
      t.integer :skill_secondary_level, default: 0
      t.integer :skill_tertiary
      t.integer :skill_tertiary_level, default: 0
      t.timestamps
    end
  end
end
