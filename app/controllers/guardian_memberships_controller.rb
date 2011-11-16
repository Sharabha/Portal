class GuardianMembershipsController < ApplicationController
  def new
    @competition = Competition.find(params[:competition_id])
    @problem = Problem.find(params[:problem_id])    
    @guardian_membership = @problem.guardian_memberships.new
  end

  def create
    @competition = Competition.find(params[:competition_id])
    @problem = Problem.find(params[:problem_id])
    @guardian_membership = @problem.guardian_memberships.create(params[:guardian_membership])
    if @guardian_membership.save
      redirect_to competition_problem_path(@competition,@problem)
    else
      render :action => :new
    end
  end

end
