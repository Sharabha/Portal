class ProblemMembershipsController < ApplicationController
    load_and_authorize_resource :except => [:new]#TODO: co z create?

  def show
    @competition = Competition.find(params[:competition_id])
    @problem_membership = @competition.problem_memberships.find(params[:id])
  end

  def new
    @competition = Competition.find(params[:competition_id])
    @problem_membership = @competition.problem_memberships.new
    authorize! :create, @problem_membership #<- ważne
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

  def edit
    @competition = Competition.find(params[:competition_id])
    @problem_membership = @competition.problem_memberships.find(params[:id])
  end

  def update
    @competition = Competition.find(params[:competition_id])
    @problem_membership = @competition.problem_memberships.find(params[:id])
    @problem_membership.update_attributes(params[:problem_membership])
    redirect_to competition_path(@competition)
  end

  def destroy
    @competition = Competition.find(params[:competition_id])
    @problem_membership = @competition.problem_memberships.find(params[:id])
    @problem_membership.destroy
    redirect_to competition_path(@competition)
  end
end
