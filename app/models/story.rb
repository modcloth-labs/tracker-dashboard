class Story < ActiveRecord::Base
  attr_accessible :current_state, :labels, :name, :owned_by, :requested_by, :tracker_id, :url, :project_id, :story_type
  has_many :labelings
  belongs_to :project
  belongs_to :iteration
end
