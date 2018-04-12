# == Schema Information
#
# Table name: skills
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :skill do
    name { %w[Keyboards Drummer Dance Vocals Guitar Bass Congas Triangle].sample }
  end
end
