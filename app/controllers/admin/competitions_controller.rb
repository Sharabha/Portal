class Admin::CompetitionsController < Admin::AdminController
  inherit_resources
  actions :new, :show
  load_and_authorize_resource :except => [:index]

  def index
    current_time = Time.now
    @current_competitions = Competition.where("start <= ? AND deadline >= ?", current_time, current_time).accessible_by(current_ability)
    @planned_competitions = Competition.where("start > ? ", current_time).accessible_by(current_ability)
    @archive_competitions = Competition.where("deadline < ?", current_time).accessible_by(current_ability)
  end

  def update
    if @competition.update_attributes(params[:competition])
      redirect_to admin_competition_path(@competition)
    else
      render :action => 'edit'
    end
  end

  def create
    #need to find if user if organizator is correct! don't trust data You receive
    if @competition.save
      redirect_to admin_competition_path(@competition)
    else
      render :action=> 'new'
    end
  end

  def destroy
    if @competition.destroy
      redirect_to admin_competitions_path
    else
      render :action => "show"
    end
  end

  def close
    @competition.deadline = DateTime.now()
    if @competition.save
      redirect_to admin_competition_path(@competition)
    else
      render :action => "show"
    end
  end

  def judges
    @judge_memberships = @competition.judge_memberships
  end

  def ranking
  end

  def teams
    @team_memberships = @competition.team_memberships
  end

  def problems
    @problems = @competition.problems
  end
end
