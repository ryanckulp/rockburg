class CreateRecordings < ActiveRecord::Migration[5.1]
  def change
    create_table :recordings do |t|
      t.references :studio
      t.references :band
      t.string :type
      t.string :name
      t.integer :quality
      t.timestamps
    end
  end
end
