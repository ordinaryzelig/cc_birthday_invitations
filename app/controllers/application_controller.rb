class ApplicationController < ActionController::Base

private

  def authenticate_admin
    authenticate_or_request_with_http_basic &auth_proc
  end

  def auth_proc
    @auth_proc ||= proc do |username, password|
      admin = Rails.application.credentials.admin
      username == admin.fetch(:username) && password == admin.fetch(:password)
    end
  end

end
