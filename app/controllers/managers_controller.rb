class ManagersController < ApplicationController
  before_action :authenticate_manager!

  def index
    @bands = current_manager.bands.all
  end
end
