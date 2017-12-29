class Activity < ApplicationRecord
  belongs_to :band

  def self.current_activity
    where('ends_at > ?', Time.now)
  end
end
