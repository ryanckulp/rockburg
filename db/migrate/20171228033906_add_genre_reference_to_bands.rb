class AddGenreReferenceToBands < ActiveRecord::Migration[5.1]
  def change
    add_reference :bands, :genre, foreign_key: true
  end
end
