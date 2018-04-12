class Manager::DailyFinancials < ApplicationService
  expects do
    required(:manager).filled
  end

  delegate :manager, to: :context

  before do
    context.manager = Manager.ensure(manager)
  end

  def call
    manager.bands.each do |band|
      result = Band::DailyUpdate.call(band: band)
      if result.success?
        manager.financials.create!(amount: -result.daily_running_costs, band: band)
        manager.financials.create!(amount: result.earnings, band: band)
      else
        # Probably should tell someone that the band couldn't update it's data
      end
    end
  end
end
