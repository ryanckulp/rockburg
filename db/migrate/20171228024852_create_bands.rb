class CreateBands < ActiveRecord::Migration[5.1]
  def change
    create_table :bands do |t|
      t.string :name, null: false, default: ""
      t.timestamps
    end
  end
end
