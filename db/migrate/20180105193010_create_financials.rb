class CreateFinancials < ActiveRecord::Migration[5.1]
  def change
    create_table :financials do |t|
      t.references  :manager, null: false
      t.references  :band, null: true
      t.references  :activity, null: true
      t.integer     :amount, default: 0
      t.integer     :balance, default: 0
      t.timestamps
    end
  end
end
