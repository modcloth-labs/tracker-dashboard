class ProjectsController < ApplicationController
  before_filter :require_credentials
  before_filter :require_password

  def index
    @active_tab = "projects"
    respond_to do |format|
      format.html {}
      format.json do
        update_data if @credentials.should_update_data?
        render :json => {:projects =>
                             Project.enabled.as_json(
                                 :include => [:iterations, :stories],
                                 :methods => [:enabled_label_ids]
                             ),
                         :labels =>
                             Label.all.as_json
        }
      end
    end
  end

  def update
    update_data
    redirect_to :back
  end

  private
  def update_data
    @credentials.fetch_projects!
    Project.fetch!
  end
end