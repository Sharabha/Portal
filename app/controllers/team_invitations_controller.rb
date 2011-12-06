class TeamInvitationsController < ApplicationController

  def confirm
  end

  def new
    @team_invitation = TeamInvitation.new
  end

  def create
    @team_invitation = TeamInvitation.new(params[:team])

    respond_to do |format|
      if @team_invitation.save
        format.html { redirect_to @team, notice: 'Invitation sent' }
        format.json { render json: @team, status: :created, location: @team }
      else
        format.html { render action: "new" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

end
