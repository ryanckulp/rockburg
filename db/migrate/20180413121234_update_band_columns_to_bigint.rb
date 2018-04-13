class UpdateBandColumnsToBigint < ActiveRecord::Migration[5.2]
  def up
    change_column :bands, :fans, :bigint, default: 0
    change_column :bands, :buzz, :bigint, default: 0
    change_column :financials, :amount, :bigint, default: 0
    change_column :financials, :balance, :bigint, default: 0
  end

  def down
    change_column :bands, :fans, :integer, default: 0
    change_column :bands, :buzz, :integer, default: 0
    change_column :financials, :amount, :integer, default: 0
    change_column :financials, :balance, :integer, default: 0
  end

end
