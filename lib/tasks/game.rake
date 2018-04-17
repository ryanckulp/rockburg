namespace :game do
  desc 'Reset everything except the Manager profiles'
  task :reset => :environment do
    puts "  Deleteing Members".yellow
    Member.delete_all

    puts "  Deleteing Game State".yellow
    MemberBand.delete_all
    Band.delete_all
    Financial.delete_all
    Activity.delete_all
    Gig.delete_all
    Recording.delete_all
    SongRecording.delete_all
    Song.delete_all
    SingleAlbum.delete_all

    puts "  Setting Starting Balance on Existing Managers".yellow
    Manager.find_each do |manager|
      manager.give_starting_balance
    end

    puts "  Creating New Members".yellow
    Rake::Task["db:seed:members"].invoke
    puts

    GameDatum.set(:last_reset, Time.now.utc)
  end
end