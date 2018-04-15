class ChartsController < ApplicationController
  def index
    @managers = Manager.includes(:most_recent_financial).order("financials.balance desc").limit(5)
    @bands = Band.order("buzz desc").limit(5)
  end

  def bands
    @bands = Band.order("buzz desc").limit(30)
  end

  def managers
    @managers = Manager.includes(:most_recent_financial).order("financials.balance desc").limit(30)
  end
end
