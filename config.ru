require 'dalli'
require File.expand_path('../ruby/tracker_dashboard', __FILE__)

module TrackerDashboard
  class Static
    def call( env )
      env['PATH_INFO'] = "/index.html" if env['PATH_INFO'] == "/"
      Rack::File.new( Dir.pwd ).call( env )
    end
  end

  class Projects
    def call( env )
      projects_json = cache.fetch('data.projects.json') do
        TrackerDashboard::DataLoad.fetch
      end

      Rack::Response.new do |res|
        res.header['Content-Type'] = 'application/json'
        res.write projects_json
      end.finish
    end

    def cache
      @cache ||= Dalli::Client.new
    end
  end
end

use Rack::Auth::Basic, "Restricted" do |username, password|
  { 'winston' => 'we<3bluetoo!' }[username] == password
end

map "/data/projects.json" do
  run TrackerDashboard::Projects.new
end

map "/" do
  run TrackerDashboard::Static.new
end