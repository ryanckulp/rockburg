class Band < ApplicationRecord
  belongs_to :manager
  belongs_to :genre
  has_many :financials
  has_many :member_bands
  has_many :members, through: :member_bands
  has_many :activities
  has_many :happenings
  has_many :songs
  has_many :gigs
  has_many :recordings
end
