# == Schema Information
#
# Table name: studios
#
#  id            :bigint(8)        not null, primary key
#  cost          :integer
#  description   :string
#  engineer_name :string
#  name          :string
#  weight        :integer          default(0)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Studio < ApplicationRecord
  has_many :recordings
  def full_studio
    "#{name} - §#{cost}"
  end
end
