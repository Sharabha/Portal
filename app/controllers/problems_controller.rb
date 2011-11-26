class ProblemsController < ApplicationController
  def index
    @problems = Problem.all
  end

  def new
    @problem = Problem.new
  end

  def show
    @problem = Problem.find(params[:id])
  end

  def create
    @problem = Problem.create(params[:problem])
    @problem.author_id = current_user.id
    if @problem.save
      redirect_to @problem
    else
      render :action => :new
    end
  end
  
  def edit
    @problem = Problem.find(params[:id])
  end

  def update
    @problem = Problem.find(params[:id])
    @problem.update_attributes(params[:problem])
    redirect_to problems_path
  end

  def destroy
    @problem = Problem.find(params[:id])
    if @problem.destroy
      redirect_to problems_path
    else
      render :action => "show"
    end
  end
end
