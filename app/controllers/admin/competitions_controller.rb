class Admin::CompetitionsController < Admin::AdminController
  inherit_resources
  actions :index, :edit, :new, :update, :create
  load_and_authorize_resource

  def show
    @competition        = Competition.find(params[:id])
    @judge_memberships = @competition.judge_memberships
    @team_memberships = @competition.team_memberships
    @problems = @competition.problems
  end

  def create
    @user = User.find(params[:competition][:organizer_id])
    create!
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
