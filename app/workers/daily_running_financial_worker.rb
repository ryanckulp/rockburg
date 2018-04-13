class DailyRunningFinancialWorker < ApplicationWorker
  def perform
    Manager.find_each do |manager|
      DailyManagerWorker.perform_later(manager: manager)
    end
  end
end
