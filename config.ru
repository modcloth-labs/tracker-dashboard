module TrackerDashboard
  class Application
    
    def call( env )
      env['PATH_INFO'] = "/index.html" if env['PATH_INFO'] == "/"
      Rack::File.new( Dir.pwd ).call( env )
    end
    
  end
end

run TrackerDashboard::Application.new