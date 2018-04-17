class ManagersController < ApplicationController
  before_action :authenticate_manager!

  def index
    @manager = current_manager
    @bands = current_manager.bands.all
    render(:action => 'show')
  end

  def show
    @manager = Manager.find(params[:id])
    @bands = @manager.bands.all
  end
end
