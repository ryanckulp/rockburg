# == Schema Information
#
# Table name: managers
#
#  id                     :bigint(8)        not null, primary key
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  name                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_managers_on_email                 (email) UNIQUE
#  index_managers_on_reset_password_token  (reset_password_token) UNIQUE
#

class Manager < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :bands
  has_many :financials
  has_many :members, through: :bands

  validates :name, uniqueness: true

  after_create :give_starting_balance

  def give_starting_balance
    self.financials.create!(amount: 50_000, balance: 50_000)
  end

  def balance
    self.financials.last.balance
  end
end
