class CreateStudios < ActiveRecord::Migration[5.1]
  def change
    create_table :studios do |t|
      t.string :name
      t.string :description
      t.string :engineer_name
      t.integer :cost
      t.timestamps
    end
  end
end
