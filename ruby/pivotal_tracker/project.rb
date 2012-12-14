require 'nokogiri'
require 'rest-client'

module PivotalTracker
  
  class Project
    
    attr_accessor :id, :name, :current_velocity, :epics
    
    def initialize( node )
      @id = node.xpath('//project//id').first.text
      @name = node.xpath('//project//name').first.text
      @current_velocity = node.xpath('//project//current_velocity').first.text
    end
    
    def self.get( token, id )
      response = RestClient.get( "http://www.pivotaltracker.com/services/v3/projects/#{id}", 'X-TrackerToken' => token )
      Project.new( Nokogiri::XML( response.body ) )
    end
    
  end
  
end