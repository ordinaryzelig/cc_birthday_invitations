class SongRequestsController < ApplicationController
  before_action :set_invitation, :only => %i[create destroy]
  before_action :set_song_request, only: [:destroy]

  # GET /song_requests
  # GET /song_requests.json
  def index
    @song_requests = SongRequest.all
  end

  # POST /song_requests
  # POST /song_requests.json
  def create
    @song_request = @invitation.song_requests.build(song_request_params)

    respond_to do |format|
      if @song_request.save
        format.html { redirect_to @invitation, notice: 'Song request was successfully created.' }
      else
        format.html { render 'invitations/show' }
      end
    end
  end

  # DELETE /song_requests/1
  # DELETE /song_requests/1.json
  def destroy
    @song_request.destroy
    redirect_to invitation_url(@invitation), notice: 'Song request deleted.'
  end

  private

    def set_invitation
      @invitation = Invitation.find_by(:code => params[:invitation_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_song_request
      @song_request = @invitation.song_requests.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def song_request_params
      params.require(:song_request).permit(:title, :artist)
    end
end
