class Gig < ApplicationRecord
  belongs_to :band
  belongs_to :venue
end
