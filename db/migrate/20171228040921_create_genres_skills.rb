class CreateGenresSkills < ActiveRecord::Migration[5.1]
  def change
    create_table :genre_skills do |t|
      t.belongs_to :genre, index: true
      t.belongs_to :skill, index: true
      t.timestamps
    end
  end
end
