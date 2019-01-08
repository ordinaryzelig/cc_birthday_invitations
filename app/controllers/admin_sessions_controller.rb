class AdminSessionsController < ApplicationController

  def destroy
    authenticate_with_http_basic {}
    render :status => 401
  end

end
