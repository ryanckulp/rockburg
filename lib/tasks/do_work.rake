namespace :do_work do
  desc 'do daily housekeeping chores'
  task :daily => :environment do
    DailyRunningFinancialWorker.new.perform
  end
end