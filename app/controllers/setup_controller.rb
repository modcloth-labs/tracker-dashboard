class SetupController < ApplicationController
  before_filter do
    @credentials = Credentials.first || Credentials.new
    @projects = @credentials.projects
  end
  before_filter :require_password

  def index
  end

  def update
    if @credentials.update_attributes(params[:credentials])
      flash[:notice] = "Settings saved."
      render :action => "index"
    else
      flash[:notice] = "Settings could not be saved."
      render :action => "index"
    end
  end
end
