task default: [ :load ]

task :load do
  require 'dalli'
  require File.expand_path('../ruby/tracker_dashboard', __FILE__)

  cache = Dalli::Client.new
  cache.set 'data.projects.json', TrackerDashboard::DataLoad.fetch
end