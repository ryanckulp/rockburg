# == Schema Information
#
# Table name: gigs
#
#  id          :bigint(8)        not null, primary key
#  fans_gained :integer
#  money_made  :integer
#  played_on   :date
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  band_id     :bigint(8)
#  venue_id    :bigint(8)
#
# Indexes
#
#  index_gigs_on_band_id   (band_id)
#  index_gigs_on_venue_id  (venue_id)
#

class Gig < ApplicationRecord
  belongs_to :band
  belongs_to :venue
end
