task :load => :environment do
  Project.fetch!
end
