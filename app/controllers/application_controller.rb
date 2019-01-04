class ApplicationController < ActionController::Base

private

  def authenticate_admin
    if authenticate_with_http_basic do |username, password|
      admin = Rails.application.credentials.admin
      username == admin.fetch(:username) && password == admin.fetch(:password)
    end
    else
      request_http_basic_authentication
    end
  end

end
