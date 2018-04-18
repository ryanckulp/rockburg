class ChartsController < ApplicationController
  def index
    @managers = Manager.joins(:bands).order(balance: :desc).group('id').limit(5)
    @bands = Band.order(buzz: :desc).limit(5)
    @releases = Recording.order(sales: :desc).where.not(release_at: nil).limit(5)
  end

  def bands
    @bands = Band.order(buzz: :desc).limit(30)
  end

  def managers
    @managers = Manager.order(balance: :desc).limit(30)
  end

  def releases
    @releases = Recording.order(sales: :desc).where.not(release_at: nil).limit(30)
  end
end
