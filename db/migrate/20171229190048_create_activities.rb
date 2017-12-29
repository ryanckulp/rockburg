class CreateActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :activities do |t|
      t.references :band
      t.string :action
      t.datetime :starts_at
      t.datetime :ends_at
      t.timestamps
    end
  end
end
