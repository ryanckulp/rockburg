class ChartsController < ApplicationController
  def index
    @managers = Financial.group(:manager_id).order('created_at DESC')
  end
end
