namespace :stations do
  desc "Check if station is reporting regularly and notify owner if it is not"
  task :check_all! => :environment do
    Station.all.each do |station|
      station.check_status!
    end
  end
end