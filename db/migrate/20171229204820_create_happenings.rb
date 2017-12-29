class CreateHappenings < ActiveRecord::Migration[5.1]
  def change
    create_table :happenings do |t|
      t.references :band
      t.string :what
      t.timestamps
    end
  end
end
