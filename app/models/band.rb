class Band < ApplicationRecord
  belongs_to :manager
  belongs_to :genre
  has_many :member_bands
  has_many :members, through: :member_bands
end
