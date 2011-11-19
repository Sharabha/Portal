class CompetitionsController < ApplicationController

  before_filter :authenticate_user!
  load_and_authorize_resource :except => [:index, :create]

  def index
    @competitions = Competition.all
  end

  def show
    @competition = Competition.find(params[:id])
  end

  def new
    @user = User.find(params[:organizer_id])
    @competition = Competition.new
    @competition.organizer_id = @user.id
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
    @competition.deadline = DateTime.now() + 5.seconds;
    if @competition.save
      redirect_to competition_path(@competition)
    else
      render :action => "show"
    end
  end

end
