class ProblemsController < ApplicationController
  def new
    @competition = Competition.find(params[:competition_id])
    @problem = @competition.problems.new
  end

  def show
    @competition = Competition.find(params[:competition_id])
    @problem = @competition.problems.find(params[:id])
  end

  def create
    @competition = Competition.find(params[:competition_id])
    @problem = @competition.problems.create(params[:problem])
    if @problem.save
      redirect_to competition_path(@competition)
    else
      render :action => :new
    end
  end
end
