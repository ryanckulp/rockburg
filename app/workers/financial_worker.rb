class FinancialWorker
  include Sidekiq::Worker

  def perform(band_id, activity, hours, song_id = nil)

  end
end
