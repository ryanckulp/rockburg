class ActivitiesController < ApplicationController
  def new
    case params[:type]
    when 'practice'
      hours = params[:hours].to_i
      end_at = Time.now + hours.hours
      @activity = Activity.new(band_id: params[:band_id], action: 'practice', starts_at: Time.now, ends_at: end_at)
      ActivityWorker.perform_at(end_at, params[:band_id], 'practice', hours)
    end

    if @activity.save
      redirect_to band_path(params[:band_id]), alert: "Activity started."
    end
  end
end
