class UserTeamMembershipsController < ApplicationController


  def new
    @team = Team.find(params[:team_id])
    @user = User.find(params[:user_id])
    @user.team_memberships.new(:team => @team)
  end

  def create
    @team = Team.find(params[:team_id])
    @user = User.find(params[:user_id])
    @user.team_memberships.new(:team => @team)
    if @user_team_membership.save
      redirect_to team_path(@team)
    else
      render :action => :new
    end
  end

  def destroy
    @team = Team.find(params[:team_id])
    @user = User.find(params[:user_id])
    @user.team_memberships.destroy(:team => @team)
    redirect_to team_path(@team)
  end

end
