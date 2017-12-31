class ActivitiesController < ApplicationController
  def new
    @band = Band.find_by_id(params[:band_id])
    case params[:type]
    when 'practice'
      hours = params[:hours].to_i
      end_at = Time.now + hours.seconds
      @activity = Activity.new(band_id: params[:band_id], action: 'practice', starts_at: Time.now, ends_at: end_at)
      ActivityWorker.perform_at(end_at, params[:band_id], 'practice', hours)
    when 'write_song'
      hours = params[:hours].to_i
      end_at = Time.now + hours.seconds
      @activity = Activity.new(band_id: params[:band_id], action: 'write_song', starts_at: Time.now, ends_at: end_at)
      song = Song.create(band_id: params[:band_id], name: Faker::Hipster.sentence(2, false, 0).gsub('.','').titleize)
      ActivityWorker.perform_at(end_at, params[:band_id], 'write_song', hours, song.id)
    when 'gig'
      hours = 24
      end_at = Time.now + hours.seconds
      @activity = Activity.new(band_id: params[:band_id], action: 'gig', starts_at: Time.now, ends_at: end_at)
      venue = Venue.find_by_id(params[:venue])
      gig = @band.gigs.create(venue_id: venue.id, played_on: Date.today)
      ActivityWorker.perform_at(end_at, params[:band_id], 'gig', hours, gig.id)
    when 'record_single'
      hours = 24
      end_at = Time.now + hours.seconds
      @activity = Activity.new(band_id: params[:band_id], action: 'record_single', starts_at: Time.now, ends_at: end_at)

      recording = @band.recordings.create(studio_id: params[:studio][:studio_id], type: 'single')
      SongRecording.create(recording_id: recording.id, song_id, params[:song_id])
      ActivityWorker.perform_at(end_at, params[:band_id], 'record_single', hours, recording.id)
    end

    if @activity.save
      redirect_to band_path(params[:band_id]), alert: "Activity started."
    end
  end
end
