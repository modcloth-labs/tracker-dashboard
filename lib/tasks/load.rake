desc "Fetch the project status"
task :load => :environment do
  Project.fetch!
end

desc "Fetch the project status every 20 (or DELAY) minutes"
task :keep_loading => :environment do
  delay = (ENV["DELAY"] ? ENV["DELAY"].to_i : 20)
  while true do
    puts "Fetching projects"
    Project.fetch!
    puts "Waiting #{delay} minutes..."
    sleep delay * 60
  end
end