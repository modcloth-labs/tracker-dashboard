class Credentials < ActiveRecord::Base
  attr_accessible :auth_password, :auth_user, :token, :projects_attributes, :reload_data_mins
  validates_presence_of :token

  after_save :fetch_projects!
  has_many :projects

  accepts_nested_attributes_for :projects

  def fetch_projects!
    dead_projects = Project.all
    Tracker::Project.all.each do |proj|
      project = projects.find_or_create_by_tracker_id(proj.id)
      project.name = proj.name
      project.all_labels = proj.labels.downcase if proj.labels.present?
      project.save!
      dead_projects.delete(project)
    end
    dead_projects.map &:destroy
  end

  def should_update_data?
    reload_data_mins > 0 && !data_last_reloaded || data_last_reloaded + reload_data_mins.minutes < Time.now
  end
end
