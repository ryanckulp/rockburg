class ChartsController < ApplicationController
  def index
    @managers = Manager.all.sort_by(&:balance).reverse!.first(50)
  end
end
