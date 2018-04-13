class ChartsController < ApplicationController
  def index
    @managers = Manager.includes(:most_recent_financial).order("financials.balance desc").limit(20)
  end
end
