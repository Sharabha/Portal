class InvitationsController < ApplicationController

  def confirm
    @invitation = Invitation.find_by_token(params[:token])
    if not @invitation.confirmed
      @invitation.confirmed = true
      if @invitation.save
        @user_team_membership = UserTeamMembership.new(:user_id => @invitation.user_id, 
                                                       :team_id => @invitation.team_id)
        if @user_team_membership.save
          redirect_to team_path(@invitation.team_id)
          return
        end
      end
    end
    redirect_to root_path
  end

  def new
    @team       = Team.find(params[:team_id])
    @invitation = Invitation.new({:team_id => @team.id})
  end

  def create
    @invitation         = Invitation.new(params[:invitation])
    @team               = Team.find(params[:team_id])
    @invitation.team_id = @team.id
    @invitation.token   = generate_token
    @user = User.find(@invitation.user_id)

    if @invitation.save
      InvitationMailer.invitation_email(@user,@invitation.token).deliver
      redirect_to team_path(@team)
    else
      render :action => :new
    end
  end

  private
  
  def generate_token
    rand(36**15).to_s(36)
  end

end
