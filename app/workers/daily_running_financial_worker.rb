require 'sidekiq-scheduler'

class DailyRunningFinancialWorker
  include Sidekiq::Worker

  def perform
    Manager.find_each do |manager|
      DailyManagerWorker.perform_later(manager: manager)
    end
  end
end
