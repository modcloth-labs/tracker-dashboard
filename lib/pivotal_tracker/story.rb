require 'nokogiri'
require 'rest-client'

module PivotalTracker
  
  class Story
    
    attr_accessor :id, :story_type, :url, :current_state, :name, :requested_by, :owned_by, :labels
    
    def initialize( node )
      @id = node.xpath('.//id').first.text
      @story_type = node.xpath('.//story_type').text
      @url = node.xpath('.//url').text
      @current_state = node.xpath('.//current_state').text
      @name = node.xpath('.//name').text
      @requested_by = node.xpath('.//requested_by').text
      @owned_by = node.xpath('.//owned_by').text
      @labels = node.xpath('.//labels').text.split(',')
    end
    
  end
  
end