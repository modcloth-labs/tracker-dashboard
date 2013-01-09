task :load => :environment do
  require 'dalli'
  require 'tracker_dashboard'

  cache = Dalli::Client.new
  cache.set 'data.projects.json', TrackerDashboard::DataLoad.fetch
end
