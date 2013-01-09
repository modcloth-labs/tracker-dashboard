class ProjectsController < ApplicationController
  before_filter :require_credentials
  before_filter :require_password
  def index
    @active_tab = "projects"
    respond_to do |format|
      format.html {}
      format.json do
        json = cache.fetch('data.projects.json') do
                  TrackerDashboard::DataLoad.fetch
                end
        render :json => json
      end
    end
  end

  def update
    cache.set( 'data.projects.json', TrackerDashboard::DataLoad.fetch )
    redirect_to('/')
  end
end
