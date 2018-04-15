class DailyRunningFinancialWorker
  include Sidekiq::Worker

  def perform
    Manager.find_each do |manager|
      DailyManagerWorker.perform_async(manager: manager)
    end
  end
end
