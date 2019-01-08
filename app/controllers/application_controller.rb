class ApplicationController < ActionController::Base

private

  def require_admin
    check_logout_param and authenticate_or_request_with_http_basic &auth_proc
  end

  # Check if admin is already logged in, but don't require it.
  def authenticate_admin
    check_logout_param and authenticate_with_http_basic &auth_proc
  end

  def auth_proc
    @auth_proc ||= proc do |username, password|
      admin = Rails.application.credentials.admin
      username == admin.fetch(:username) && password == admin.fetch(:password) && login_admin!
    end
  end

  def check_logout_param
    if params[:logout]
      authenticate_with_http_basic {}
      render 'admin_sessions/destroy', :status => 401
    else
      true
    end
  end

  def login_admin!
    puts 'login_admin'
    @logged_in_as_admin = true
  end

  def logged_in_as_admin?
    @logged_in_as_admin
  end
  helper_method :logged_in_as_admin?

end
