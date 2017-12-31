class Studio < ApplicationRecord

  def full_studio
    "#{name} - §#{cost}"
  end
end
