class CompetitionsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :except => :index

  def index
    @competitions = Competition.all
  end

  def show
    @competition        = Competition.find(params[:id])
    @judge_memberships  = JudgeMembership
    @team_memberships  = TeamMembership
    @problems = @competition.problems
  end

  def edit
    @competition = Competition.find(params[:id])
  end

  def update
    @competition = Competition.find(params[:id])
    if @competition.update_attributes(params[:competition])
      redirect_to competition_path(@competition)
    else
      render :action => :edit
    end
  end 

  def new
    @competition = Competition.new
  end

  def create
    @user = User.find(params[:competition][:organizer_id])
    @competition = Competition.new(params[:competition])
    if @competition.save
      redirect_to competition_path(@competition)
    else
      render :action => :new
    end
  end

  def destroy
    @competition = Competition.find(params[:id])
    if @competition.destroy
      redirect_to competitions_path
    else
      render :action => "show"
    end
  end

  def close
    @competition          = Competition.find(params[:id])
    @competition.deadline = DateTime.now()
    if @competition.save
      redirect_to competition_path(@competition)
    else
      render :action => "show"
    end
  end

end
