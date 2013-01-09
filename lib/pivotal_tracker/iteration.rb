require 'nokogiri'
require 'rest-client'

module PivotalTracker
  
  class Iteration
    
    attr_accessor :start, :finish, :team_strength, :stories
    
    def initialize( node )
      iteration = node.xpath('//iterations//iteration').first
      
      @start = iteration.xpath('.//start').text
      @finish = iteration.xpath('.//finish').text
      @team_strength = iteration.xpath('.//team_strength').text
      
      @stories = iteration.xpath('.//stories//story').map { |s| Story.new( s ) }
    end
    
    def self.get( token, id )
      response = RestClient.get( "https://www.pivotaltracker.com/services/v3/projects/#{id}/iterations/current_backlog", 'X-TrackerToken' => token )
      Iteration.new( Nokogiri::XML( response.body ) )
    end
    
  end
  
end
