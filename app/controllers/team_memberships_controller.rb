class TeamMembershipsController < ApplicationController
    load_and_authorize_resource :except => [:read,:create,:new]#TODO: co z create?

  def show
    @competition = Competition.find(params[:competition_id])
    @team_membership = @competition.team_memberships.find(params[:id])
  end

  def new
    @competition = Competition.find(params[:competition_id])
    @team_membership = @competition.team_memberships.new
    authorize! :new, @team_membership
  end

  def create
    @competition = Competition.find(params[:competition_id])
    @team_membership = @competition.team_memberships.create(params[:team_membership])
    authorize! :create, @team_membership
    if @team_membership.save
      redirect_to competition_path(@competition)
    else
      render :action => :new
    end
  end

  def destroy
    @competition = Competition.find(params[:competition_id])
    @team_membership = @competition.team_memberships.find(params[:id])
    @team_membership.destroy
    redirect_to competition_path(@competition)
  end
end
