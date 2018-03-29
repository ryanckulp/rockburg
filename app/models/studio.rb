class Studio < ApplicationRecord
  has_many :recordings
  def full_studio
    "#{name} - §#{cost}"
  end
end
