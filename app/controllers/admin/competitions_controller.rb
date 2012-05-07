class Admin::CompetitionsController < Admin::AdminController
  inherit_resources
  actions :new
  load_and_authorize_resource
  
  def index
    current_time = Time.now
    @current_competitions = Competition.where("start <= ? AND deadline >= ?", current_time, current_time)
    @planned_competitions = Competition.where("start > ? ", current_time)
    @archive_competitions = Competition.where("deadline < ?", current_time)
  end
  
  def show
    @competition = Competition.find(params[:id])
  end
  def update
    @competition = Competition.find(params[:id])
    if @competition.update_attributes(params[:competition])
		redirect_to admin_competition_path(@competition)
    else
		render :action => 'edit'
    end
  end
  def create
    @competition = Competition.new(params[:competition])
    #need to find if user if organizator is correct! don't trust data You receive
    if @competition.save
		redirect_to admin_competition_path(@competition)
    else
		render :action=> 'new'
    end
  end
  def destroy
    @competition = Competition.find(params[:id])
    if @competition.destroy
      redirect_to admin_competitions_path
    else
      render :action => "show"
    end
  end
  def close
    @competition = Competition.find(params[:id])
    @competition.deadline = DateTime.now()
    if @competition.save
      redirect_to admin_competition_path(@competition)
    else
      render :action => "show"
    end
  end
  def judges
    @competition = Competition.find(params[:competition_id])
    @judge_memberships = @competition.judge_memberships
  end
  def ranking
    @competition = Competition.find(params[:competition_id])
  end
  def teams
    @competition = Competition.find(params[:competition_id])
    @team_memberships = @competition.team_memberships
  end
  def problems
    @competition = Competition.find(params[:competition_id])
    @problems = @competition.problems
  end
end
