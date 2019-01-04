class AdminSessionsController < ApplicationController

  before_action :authenticate_admin

  def new
    redirect_to invitations_url
  end

end
