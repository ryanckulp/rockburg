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
      current_manager.financials.create!(amount: -10000, band_id: @band.id)
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
    @band = Band.find(params[:id])
    @activity = @band.activities.current_activity.try(:last)
  end

  private

  def band_params
    params.require(:band).permit(:name, :genre_id)
  end
end
