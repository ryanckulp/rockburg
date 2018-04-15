# == Schema Information
#
# Table name: member_bands
#
#  id             :bigint(8)        not null, primary key
#  joined_band_at :datetime
#  left_band_at   :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  band_id        :bigint(8)
#  member_id      :bigint(8)
#  skill_id       :bigint(8)
#
# Indexes
#
#  index_member_bands_on_band_id    (band_id)
#  index_member_bands_on_member_id  (member_id)
#  index_member_bands_on_skill_id   (skill_id)
#

class MemberBand < ApplicationRecord
  belongs_to :member
  belongs_to :band
  belongs_to :skill
end
