class ActivitiesController < ApplicationController
  def new
    @band = Band.find_by_id(params[:band_id])

    case params[:type]
    when 'practice'
      @activity = Activity::Practice.(band: params[:band_id], hours: params[:hours]).activity

    when 'write_song'
      @activity = Activity::WriteSong.(band: params[:band_id], hours: params[:hours]).activity

    when 'gig'
      @activity = Activity::PlayGig.(band: params[:band_id], venue: params[:venue], hours: params[:hours] || 6).activity

    when 'record_single'
      @activity = Activity::RecordSingle.(band: params[:band_id], studio: params[:studio][:studio_id], song: params[:song_id], song_name: params[:studio][:song_name]).activity

    when 'record_album'
      @activity = Activity::RecordAlbum.(band: params[:band_id], studio: params[:studio][:id], recording_ids: params[:recording_ids])

    when 'release'
      @activity = Activity::ReleaseRecording.(band: params[:band_id], recording: params[:recording][:id], hours: 24)

    when 'rest'
      @activity = Activity::Rest.(band: params[:band_id], hours: params[:hours].to_i).activity
    end

    if @activity.save
      redirect_to band_path(params[:band_id]), alert: "Activity started."
    end
  end
end
