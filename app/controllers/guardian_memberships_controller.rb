class GuardianMembershipsController < ApplicationController
  def new
    @competition = Competition.find(params[:competition_id])
    @problem_membership = ProblemMembership.find(params[:problem_membership_id])    
    @problem = Problem.find(@problem_membership.problem_id)
    @guardian_membership = @problem_membership.guardian_memberships.new
  end

  def create
    @competition = Competition.find(params[:competition_id])
    @problem_membership = ProblemMembership.find(params[:problem_membership_id])    
    @guardian_membership = @problem_membership.guardian_memberships.create(params[:guardian_membership])
    if @guardian_membership.save
      redirect_to competition_path(@competition)
    else
      render :action => :new
    end
  end

  def destroy
    @competition = Competition.find(params[:competition_id])
    @problem_membership = ProblemMembership.find(params[:problem_membership_id])    
    @guardian_membership = @problem_membership.guardian_memberships.find_by_guardian_id(params[:id])
    @guardian_membership.destroy
    redirect_to competition_path(@competition)
  end
end
