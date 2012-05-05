class Admin::CompetitionsController < Admin::AdminController
  inherit_resources
  actions :index, :new
  load_and_authorize_resource

  def show
    @competition = Competition.find(params[:id])
    @judge_memberships = @competition.judge_memberships
    @team_memberships = @competition.team_memberships
    @problems = @competition.problems
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
end
