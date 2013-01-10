class ProjectsController < ApplicationController
  before_filter :require_credentials
  before_filter :require_password
  def index
    @active_tab = "projects"
    respond_to do |format|
      format.html {}
      format.json do
        data = Parameter.find_or_initialize_by_name('data.projects.json')
        if data.new_record?
          data.update_attributes!(:value => TrackerDashboard::DataLoad.fetch)
        end
        render :json => data.value
      end
    end
  end

  def update
    Parameter.find_or_initialize_by_name('data.projects.json').update_attributes!(:value => TrackerDashboard::DataLoad.fetch)
    redirect_to('/')
  end
end
