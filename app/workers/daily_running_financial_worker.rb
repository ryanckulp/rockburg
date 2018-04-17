class DailyRunningFinancialWorker < ApplicationWorker
  def perform
    Manager.find_each do |manager|
      DailyManagerWorker.perform_async(manager.to_global_id)
    end
  end
end
