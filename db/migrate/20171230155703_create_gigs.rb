class CreateGigs < ActiveRecord::Migration[5.1]
  def change
    create_table :gigs do |t|
      t.references :band
      t.references :venue
      t.integer :fans_gained
      t.integer :money_made
      t.date :played_on
      t.timestamps
    end
  end
end
