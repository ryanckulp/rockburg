# == Schema Information
#
# Table name: venues
#
#  id          :bigint(8)        not null, primary key
#  capacity    :integer
#  description :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Venue < ApplicationRecord
  has_many :gigs
end
