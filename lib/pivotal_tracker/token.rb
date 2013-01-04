require 'nokogiri'
require 'rest-client'

module PivotalTracker
  
  class Token
    
    def self.get( username, password )
      options = { username: username, password: password }
      response = RestClient.post( 'https://www.pivotaltracker.com/services/v3/tokens/active', options )
      body = Nokogiri::XML( response.body )
      body.xpath('//token//guid').first.text
    end
    
  end
  
end