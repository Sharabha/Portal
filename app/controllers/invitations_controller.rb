class InvitationsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @invitations = Invitation.where(:user_id => current_user.id, :confirmed => false)
  end

  def confirm
    @invitation = Invitation.find_by_token(params[:token])
    not_found unless @invitation && !@invitation.confirmed && @invitation.user_id == current_user.id
    if params[:answer] == 'yes'
      @invitation.update_attribute(:confirmed, true)
      unless UserTeamMembership.new(:user_id => @invitation.user_id, :team_id => @invitation.team_id).save
        flash[:error] = I18n.t(:something_went_wrong)
      end
      redirect_to @invitation.team
    else
      @invitation.destroy
      redirect_to root_path
    end
  end

  def new
    @invitation = Invitation.new
    @team       = Team.find(params[:team_id])
    @invitation.team_id = @team.id
    @invitation.token   = generate_token
  end

  def create
    @invitation         = Invitation.new(params[:invitation])
    @team               = Team.find(params[:team_id])
    @invitation.team_id = @team.id
    @invitation.token   = generate_token
    @user = User.find(@invitation.user_id)

    if @invitation.save
      InvitationMailer.invitation_email(@user,@invitation.token).deliver
      redirect_to @team
    else
      flash[:error] = I18n.t(:already_invited)
      render :action => :new
    end
  end

  private
    def generate_token
      rand(36**15).to_s(36)
    end
end
