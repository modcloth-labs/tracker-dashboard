require './pivotal_tracker/iteration'
require './pivotal_tracker/project'
require './pivotal_tracker/story'
require './pivotal_tracker/token'
require 'yajl'

module TrackerDashboard
  
  class JSON
    def self.get( name )
      Yajl::Parser.parse( File.open( File.expand_path( "config/#{name}.json" ) ) ).fetch( name )
    end
  end
  
  class DataLoad
    def self.execute
      credentials = TrackerDashboard::JSON.get( 'credentials' )
      token = PivotalTracker::Token.get( credentials['username'], credentials['password'] )
      data = { projects: [] }
      
      TrackerDashboard::JSON.get( 'projects' ).each do |p|
        project = PivotalTracker::Project.get( token, p['id'] )
        iteration = PivotalTracker::Iteration.get( token, p['id'] )
        
        labels = p['epics'].push( 'uncategorized' )
        epics = labels.map { |e| { name: e, progress: {}, stories: [] } }
        
        progress_hash = {
          unstarted: 0,
          started: 0,
          finished: 0,
          delivered: 0,
          rejected: 0,
          accepted: 0
        }
        
        iteration_hash = {
          start: iteration.start,
          finish: iteration.finish
        }
        
        iteration.stories.each do |story|
          story_hash = {
            id: story.id,
            name: story.name,
            story_type: story.story_type,
            current_state: story.current_state
          }
          
          progress_hash[story.current_state.to_sym] += 1
          
          epics_in_story = story.labels & labels
          if epics_in_story.size == 0
            epics.last[:stories] << story_hash
            epics.last[:progress][story.current_state.to_sym] = 0 unless epics.last[:progress].has_key?( story.current_state.to_sym )
            epics.last[:progress][story.current_state.to_sym] += 1
          else
            epics_in_story.each do |e|
              index = labels.index( e )
              epics[index][:stories] << story_hash
              epics[index][:progress][story.current_state.to_sym] = 0 unless epics[index][:progress].has_key?( story.current_state.to_sym )
              epics[index][:progress][story.current_state.to_sym] += 1
            end
          end
        end
        
        project_hash = {
          id: project.id,
          name: project.name,
          progress: progress_hash,
          iteration: iteration_hash,
          epics: epics
        }
        
        data[:projects] << project_hash
      end
      
      File.open( "#{File.dirname(__FILE__)}/../data/projects.json", "w" ) do |f|
        f.write( Yajl::Encoder.encode( data ) )
      end
    end
  end
  
end

TrackerDashboard::DataLoad.execute