class CreateMemberBands < ActiveRecord::Migration[5.1]
  def change
    create_table :member_bands do |t|
      t.belongs_to :member, index: true
      t.belongs_to :band, index: true
      t.references :skill
      t.datetime :joined_band_at
      t.datetime :left_band_at
      t.timestamps
    end
  end
end
