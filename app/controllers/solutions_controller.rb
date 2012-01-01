#encoding: utf-8
class SolutionsController < ApplicationController
  load_and_authorize_resource :except => [:new, :create]
  before_filter :authenticate_user!
  before_filter :authenticate_team_leader, :except => [:show]
  before_filter :prepare_params, :only => [:create, :update]

  def show
    @competition = Competition.find(params[:competition_id])
    @problem_membership = @competition.problem_memberships.find(params[:problem_membership_id])
    @solution = @problem_membership.solutions.find(params[:id])
  end 

  def new
    @competition = Competition.find(params[:competition_id])
    @problem_membership = @competition.problem_memberships.find(params[:problem_membership_id])
    @solution = @problem_membership.solutions.new
  end

  def create
    @competition = Competition.find(params[:competition_id])
    @problem_membership = @competition.problem_memberships.find(params[:problem_membership_id])

    @solution = @problem_membership.solutions.new(@params)
    authorize! :create, @solution
    if @solution.save
      redirect_to competition_problem_membership_solution_path(@competition, @problem_membership, @solution), :notice => "Dodano rozwiązanie" 
    else
      render :action => "new"
    end
  end

  def edit
    @competition = Competition.find(params[:competition_id])
    @problem_membership = @competition.problem_memberships.find(params[:problem_membership_id])
    @solution = @problem_membership.solutions.find(params[:id])
  end 

  def update
    @competition = Competition.find(params[:competition_id])
    @problem_membership = @competition.problem_memberships.find(params[:problem_membership_id])
    @solution = @problem_membership.solutions.find(params[:id])
    if @solution.update_attributes(@params)
      redirect_to competition_problem_membership_solution_path(@competition, @problem_membership, @solution), :notice => "Zmieniono rozwiązanie" 
    else
      render :action => "edit"
    end
  end 

  def destroy
    @competition = Competition.find(params[:competition_id])
    @problem_membership = @competition.problem_memberships.find(params[:problem_membership_id])
    @solution = @problem_membership.solutions.find(params[:id])
    @solution.destroy
    redirect_to competition_problem_membership_path(@competition, @problem_membership), :notice => "Usunięto rozwiązanie" 
  end


  protected
    def authenticate_team_leader
      competition = Competition.find(params[:competition_id])
      problem_membership = competition.problem_memberships.find(params[:problem_membership_id])
      team = competition.teams.where(:leader_id => current_user.id).first
      if team.blank?
        flash[:alert]  = "Tylko lider zespołu może zgłaszać rozwiązanie"
        redirect_to competition_problem_membership_path(competition, problem_membership)
      end     
    end

    def prepare_params
      competition = Competition.find(params[:competition_id])
      #this one is really WTF solution, but I can't find better one
      current_team_membership = competition.team_memberships.find_by_team_id(competition.teams.where(:leader_id => current_user.id))
      @params = params[:solution].merge({:team_membership => current_team_membership})
    end

end
