class MoveBalanceToManagers < ActiveRecord::Migration[5.2]
  def up
    add_column :managers, :balance, :bigint, default: 0
    Manager.reset_column_information
    Manager.find_each do |manager|
      manager.update_balance!
    end
    add_index :managers, :balance
    remove_column :financials, :balance
  end

  def down
    add_column :financials, :balance, :bitint, default: 0
    remove_index :managers, :balance
    remove_column :managers, :balance
    Financial.reset_column_information
    Manager.reset_column_information
    Manager.find_each do |manager|
      prev_financial = nil
      manager.financials.order(:created_at).each do |financial|
        if prev_financial
          financial.balance = prev_financial.balance + financial.amount
        else
          financial.balance = financial.amount
        end
        financial.save
      end
    end
  end
end
