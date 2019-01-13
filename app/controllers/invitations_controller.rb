require 'csv'

class InvitationsController < ApplicationController
  before_action :require_admin, :only => %i[index create new]
  before_action :authenticate_admin, :only => %i[show edit]
  before_action :set_invitation, only: [:show, :edit, :update, :destroy]

  # GET /invitations
  # GET /invitations.json
  def index
    respond_to do |format|
      format.html { @invitations_by_status = Invitation.all.group_by(&:status) }
      format.csv { send_data csv }
    end
  end

  # GET /invitations/1
  # GET /invitations/1.json
  def show
    if @invitation.first_name.blank?
      render :edit
    else
      @song_request = SongRequest.new(:invitation => @invitation)
    end
  end

  # GET /invitations/new
  def new
    @invitation = Invitation.new
  end

  # GET /invitations/1/edit
  def edit
  end

  # POST /invitations
  # POST /invitations.json
  def create
    @invitation = Invitation.new(invitation_params)

    respond_to do |format|
      if @invitation.save
        format.html { redirect_to @invitation, notice: 'Invitation was successfully created.' }
        format.json { render :show, status: :created, location: @invitation }
      else
        format.html { render :new }
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invitations/1
  # PATCH/PUT /invitations/1.json
  def update
    respond_to do |format|
      if @invitation.update(invitation_params)
        format.html do
          notice =
            if @invitation.dj_name_previous_change&.first.nil?
              "Welcome #{@invitation.dj_name}"
            else
              'Invitation was successfully updated.'
            end
          redirect_to @invitation, notice: notice
        end
        format.json { render :show, status: :ok, location: @invitation }
      else
        format.html { render :edit }
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
      end
    end
  end

  def find
    if params[:code] && invitation = Invitation.find_by_code(params[:code])
      redirect_to invitation_path(invitation)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invitation
      @invitation = Invitation.find_by!(:code => params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invitation_params
      params.require(:invitation).permit(:first_name, :last_name, :email, :status)
    end

    def csv
      CSV.generate(headers: true) do |csv|
        column_names = Invitation.column_names
        csv << column_names
        Invitation.order(:status, :last_name, :first_name).find_each do |invitation|
          csv << invitation.attributes.values_at(*column_names)
        end
      end
    end
end
