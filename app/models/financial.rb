# == Schema Information
#
# Table name: financials
#
#  id          :bigint(8)        not null, primary key
#  amount      :integer          default(0)
#  balance     :integer          default(0)
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

  after_commit :adjust_balance, on: :create

  scope :recent, -> { order(created_at: :desc) }
  scope :most_recent, ->{ order(created_at: :desc).limit(1) }

  def adjust_balance
    line_item = amount
    if balance.zero?
      last_balance = manager.financials.recent.second.balance
      new_balance = last_balance + line_item
      update_columns(balance: new_balance)
    end
  end
end
