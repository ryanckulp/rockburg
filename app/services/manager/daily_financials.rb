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
        manager.sub_money(result.daily_running_costs, band: band)
        manager.add_money(result.earnings, band: band)
      else
        # Probably should tell someone that the band couldn't update it's data
      end
    end
  end
end
