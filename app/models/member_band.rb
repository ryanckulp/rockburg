class MemberBand < ApplicationRecord
  belongs_to :member
  belongs_to :band
end
