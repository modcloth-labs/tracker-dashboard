class ProjectsController < ApplicationController
  before_filter :require_credentials
  before_filter :require_password

  def index
    @active_tab = "projects"
    respond_to do |format|
      format.html {}
      format.json do
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
    Project.fetch!
    redirect_to('/')
  end
end