class ChartsController < ApplicationController
  def index
    @managers = Manager.includes(:most_recent_financial).joins(:bands).order("financials.balance desc").select("COUNT(bands.id) as bands_count").group('managers.id, financials.id').limit(5)
    @bands = Band.order("buzz desc").limit(5)
    @releases = Recording.order("sales desc").where.not(release_at: nil).limit(5)
  end

  def bands
    @bands = Band.order("buzz desc").limit(30)
  end

  def managers
    @managers = Manager.includes(:most_recent_financial).joins(:bands).order("financials.balance desc").select("COUNT(bands.id) as bands_count").group('managers.id, financials.id').limit(30)
  end

  def releases
    @releases = Recording.order("sales desc").where.not(release_at: nil).limit(30)
  end
end
