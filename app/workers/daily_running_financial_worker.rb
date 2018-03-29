class DailyRunningFinancialWorker
  include Sidekiq::Worker

  def perform
    Manager.all.each do |manager|
      manager.bands.each do |band|
        daily_running_costs = 0
        band.members.each do |member|
          daily_running_costs = daily_running_costs + member.cost_generator
        end
        manager.financials.create!(amount: -daily_running_costs, band_id: band.id)
        band.happenings.create(what: "#{band.name} just spent #{daily_running_costs} on daily running costs.")
        daily_running_costs = 0
      end
    end
  end
end
