require 'nokogiri'
require 'rest-client'

module PivotalTracker
  
  class Project
    
    attr_accessor :id, :name, :current_velocity, :epics, :labels
    
    def initialize( node )
      @id = node.css('> id').first.text
      @name = node.css('> name').first.text
      @current_velocity = node.css('> current_velocity').first.text
      @labels = node.css('> labels').first.text
    end
    
    def self.get( token, id )
      response = RestClient.get( "https://www.pivotaltracker.com/services/v3/projects/#{id}", 'X-TrackerToken' => token )
      Project.new( Nokogiri::XML( response.body ).xpath("//project") )
    end

    def self.all(token)
      response = RestClient.get( "https://www.pivotaltracker.com/services/v3/projects", 'X-TrackerToken' => token )
      Nokogiri::XML(response.body).xpath("//projects/project").to_a.map{|proj| Project.new(proj) }
    end
    
  end
  
end
