task :load => :environment do
  Parameter.find_or_initialize_by_name('data.projects.json').update_attributes!(:value => TrackerDashboard::DataLoad.fetch)
end
