class Activity < ApplicationRecord
  belongs_to :band
  belongs_to :financial, optional: true

  def self.current_activity
    where('ends_at > ?', Time.now)
  end
end
