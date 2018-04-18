class BandsController < ApplicationController
  def index
  end

  def new
    @band = Band.new
  end

  def create
    @band = Band.new(band_params)
    @band.manager = current_manager
    if @band.save
      Manager::SpendMoney.(manager: current_manager, amount: 10_000, band: @band)
      @band.happenings.create(what: "#{@band.name} has just been formed!")
      redirect_to @band, alert: "Band created successfully."
    else
      redirect_to new_band_path, alert: "Error creating band."
    end
  end

  def edit
  end

  def update
  end

  def show
    @band = Band.where(id: params[:id]).first
    if !@band
      redirect_to dashboard_path
      return
    end
    @activity = @band.activities.current_activity.try(:last)
  end

  private

  def band_params
    params.require(:band).permit(:name, :genre_id)
  end
end
