namespace :do_work do
  desc 'do daily housekeeping chores'
  task :daily => :environment do
    Manager.find_each do |manager|
      DailyManagerWorker.perform_later(manager: manager)
    end
  end
end