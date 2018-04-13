# == Schema Information
#
# Table name: financials
#
#  id          :bigint(8)        not null, primary key
#  amount      :bigint(8)        default(0)
#  balance     :bigint(8)        default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  activity_id :bigint(8)
#  band_id     :bigint(8)
#  manager_id  :bigint(8)        not null
#
# Indexes
#
#  index_financials_on_activity_id  (activity_id)
#  index_financials_on_band_id      (band_id)
#  index_financials_on_manager_id   (manager_id)
#

class Financial < ApplicationRecord
  belongs_to :band, optional: true
  has_many :activities
  belongs_to :manager

  after_create :adjust_balance

  def adjust_balance
    line_item = amount
    if balance.zero?
      last_balance = manager.financials.order('created_at DESC').offset(1).first.balance
      new_balance = last_balance + line_item
      update_attributes(balance: new_balance)
    end
  end
end
