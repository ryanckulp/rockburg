class DailyRunningFinancialWorker < ApplicationWorker
  def perform
    Manager.find_each do |manager|
      DailyManagerWorker.perform_async(manager: manager)
    end
  end
end
