class Financial < ApplicationRecord
  belongs_to :band, optional: true
  has_many :activities
  belongs_to :manager

  after_create :adjust_balance

  def adjust_balance
    line_item = amount
    if balance == 0
      last_balance = manager.financials.order('created_at DESC').offset(1).first.balance
      new_balance = last_balance + line_item
      update_attributes(balance: new_balance)
    end
  end
end
