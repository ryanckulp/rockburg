# == Schema Information
#
# Table name: single_albums
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  album_id   :integer
#  single_id  :integer
#

class SingleAlbum < ApplicationRecord
  belongs_to :recording, optional: true, foreign_key: :album_id, primary_key: :id
end
