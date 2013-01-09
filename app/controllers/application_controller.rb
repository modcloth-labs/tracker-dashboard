class ApplicationController < ActionController::Base
  protect_from_forgery

  def cache
    @cache ||= Dalli::Client.new
  end

  def require_credentials
    @credentials = Credentials.first
    redirect_to setup_path unless @credentials
  end

  def require_password
    if @credentials.auth_user.present? && @credentials.auth_password.present?
      authenticate_or_request_with_http_basic do |user, pass|
        @credentials.auth_user == user && @credentials.auth_password == pass
      end
    end
  end
end
