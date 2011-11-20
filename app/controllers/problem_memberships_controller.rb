class ProblemMembershipsController < ApplicationController

  def show
    @competition = Competition.find(params[:competition_id])
    @problem_membership = @competition.problem_memberships.find(params[:id])
  end

  def new
    @competition = Competition.find(params[:competition_id])
    @problem_membership = @competition.problem_memberships.new
  end

  def create
    @competition = Competition.find(params[:competition_id])
    @problem_membership = @competition.problem_memberships.create(params[:problem_membership])
    if @problem_membership.save
      redirect_to competition_path(@competition)
    else
      render :action => :new
    end
  end

  def destroy
    @competition = Competition.find(params[:competition_id])
    @problem_membership = @competition.problem_memberships.find(params[:id])
    @problem_membership.destroy
    redirect_to competition_path(@competition)
  end
end
