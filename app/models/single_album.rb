class SingleAlbum < ApplicationRecord
  belongs_to :recording, optional: true, :foreign_key => :album_id, :primary_key => :id
end
