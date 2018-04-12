class DailyManagerWorker
  include Sidekiq::Worker

  def perform(manager)
    Manager::DailyFinancials.(manager: manager)
  end
end
