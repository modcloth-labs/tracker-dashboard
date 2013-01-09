class Credentials < ActiveRecord::Base
  attr_accessible :auth_password, :auth_user, :token, :projects_attributes
  validates_presence_of :token

  after_save :fetch_projects
  has_many :projects

  accepts_nested_attributes_for :projects

  def fetch_projects
    PivotalTracker::Project.all(token).each do |proj|
      project = projects.find_or_create_by_tracker_id(proj.id)
      project.name = proj.name
      project.all_labels = proj.labels
      project.save!
    end
  end
end
