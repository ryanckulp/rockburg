class Activity < ApplicationRecord
  belongs_to :band
  belongs_to :financial

  def self.current_activity
    where('ends_at > ?', Time.now)
  end
end
