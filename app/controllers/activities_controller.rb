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
      hours = 24
      end_at = Time.now + hours.seconds
      @activity = Activity.new(band_id: params[:band_id], action: 'record_album', starts_at: Time.now, ends_at: end_at)

      album_name = params[:studio][:name].present? ? params[:studio][:name] : Generator.album_name

      album = @band.recordings.create(studio_id: params[:studio][:studio_id], kind: 'album', name: album_name)

      recordings = params[:recording_ids]
      recordings.each do |recording|
        SingleAlbum.create!(album_id: album.id, single_id: recording.to_i)
      end
      ActivityWorker.perform_at(end_at, params[:band_id], 'record_album', hours, album.id)

    when 'release'
      hours = 24
      end_at = Time.now + hours.seconds
      @activity = Activity.new(band_id: params[:band_id], action: 'release', starts_at: Time.now, ends_at: end_at)

      release = Recording.find_by_id(params[:recording][:id])

      ActivityWorker.perform_at(end_at, params[:band_id], 'release', hours, release.id)

    when 'rest'
      @activity = Activity::Rest.(band: params[:band_id], hours: params[:hours].to_i).activity
    end

    if @activity.save
      redirect_to band_path(params[:band_id]), alert: "Activity started."
    end
  end
end
