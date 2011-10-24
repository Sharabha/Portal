class CompetitorMembershipsController < ApplicationController
  def new
    @competition = Competition.find(params[:competition_id])
    @competitor_membership = @competition.competitor_memberships.new
  end

  def create
    @competition = Competition.find(params[:competition_id])
    @competitor_membership = @competition.competitor_memberships.create(params[:competitor_membership])
    if @competitor_membership.save
      redirect_to competition_path(@competition)
    else
      render :action => :new
    end
  end
end
