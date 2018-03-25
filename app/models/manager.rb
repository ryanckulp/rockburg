class Manager < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :bands
  has_many :financials

  after_create :give_starting_balance

  def give_starting_balance
    self.financials.create!(amount: 50000, balance: 50000)
  end

  def balance
    self.financials.last.balance
  end
end
