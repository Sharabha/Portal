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
    @competition = Competition.new
  end

  def create
    @competition = Competition.new(params[:competition])
    if @competition.save
      redirect_to competition_path(@competition)
    else
      render :action => "new"
    end
  end

end
