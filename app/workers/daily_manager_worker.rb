class DailyManagerWorker < ApplicationWorker
  def perform(manager)
    Manager::DailyFinancials.(manager: manager)
  end
end
