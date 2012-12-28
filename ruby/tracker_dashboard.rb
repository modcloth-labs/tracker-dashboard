Dir.glob( "#{File.dirname( File.absolute_path __FILE__ )}/pivotal_tracker/*", &method( :require ) )

require 'yajl'

module TrackerDashboard
  
  class JSON
    def self.get( name )
      Yajl::Parser.parse( TrackerDashboard::JSON.open_file name ).fetch( name )
    end
    
    def self.open_file( name)
      File.open( "#{File.dirname __FILE__}/config/#{name}.json" )
    end
  end
  
  class DataLoad
    
    def self.progress_hash
      { unstarted: 0, started: 0, finished: 0, delivered: 0, rejected: 0, accepted: 0 }
    end
    
    def self.iteration_hash( iteration )
      {
        start: iteration.start, 
        finish: iteration.finish
      }
    end
    
    def self.story_hash( story )
      {
        id: story.id,
        name: story.name,
        story_type: story.story_type,
        current_state: story.current_state
      }
    end
    
    def self.project_hash( project, epics, progress_hash, iteration_hash )
      {
        id: project.id,
        name: project.name,
        progress: progress_hash,
        iteration: iteration_hash,
        epics: epics
      }
    end
    
    def self.execute
      credentials = TrackerDashboard::JSON.get( 'credentials' )
      token = PivotalTracker::Token.get( credentials['username'], credentials['password'] )
      data = { projects: [] }
      
      TrackerDashboard::JSON.get( 'projects' ).each do |p|
        project = PivotalTracker::Project.get( token, p['id'] )
        iteration = PivotalTracker::Iteration.get( token, p['id'] )
        
        labels = p['epics'].push( 'uncategorized' )
        epics = labels.map { |e| { name: e, progress: {}, stories: [] } }
        
        progress_hash = TrackerDashboard::DataLoad.progress_hash
        iteration_hash = TrackerDashboard::DataLoad.iteration_hash( iteration )
        
        iteration.stories.each do |story|
          next if story.story_type == 'release'
          
          story_hash = TrackerDashboard::DataLoad.story_hash( story )
          
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
        
        data[:projects] << TrackerDashboard::DataLoad.project_hash( project, epics, progress_hash, iteration)
      end
      
      File.open( "#{File.dirname( __FILE__ )}/../data/projects.json", "w" ) do |f|
        f.write( Yajl::Encoder.encode( data ) )
      end
    end
  end
  
end

TrackerDashboard::DataLoad.execute