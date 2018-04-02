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

      if params[:studio][:name].present?
        song_name = params[:studio][:name]
      else
        song = Song.find_by_id(params[:song_id])
        song_name = song.name
      end

      recording = @band.recordings.create(studio_id: params[:studio][:studio_id], kind: 'single', name: song_name)
      SongRecording.create(recording_id: recording.id, song_id: params[:song_id])
      ActivityWorker.perform_at(end_at, params[:band_id], 'record_single', hours, recording.id)
    when 'record_album'
      hours = 24
      end_at = Time.now + hours.seconds
      @activity = Activity.new(band_id: params[:band_id], action: 'record_album', starts_at: Time.now, ends_at: end_at)

      if params[:studio][:name].present?
        album_name = params[:studio][:name]
      else
        album_name = Faker::Hipster.sentence(2, false, 0).gsub('.','').titleize
      end

      album = @band.recordings.create(studio_id: params[:studio][:studio_id], kind: 'album', name: album_name)

      recordings = params[:recording_ids]
      recordings.each do |recording|
        SingleAlbum.create!(album_id: album.id, single_id: recording.to_i)
      end
      ActivityWorker.perform_at(end_at, params[:band_id], 'record_album', hours, album.id)
    end

    if @activity.save
      redirect_to band_path(params[:band_id]), alert: "Activity started."
    end
  end
end
