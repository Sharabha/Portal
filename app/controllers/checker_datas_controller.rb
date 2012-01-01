class CheckerDatasController < ApplicationController
  def new
    @problem = Problem.find(params[:problem_id])
    @checker = @problem.checker
    @checker_data = @checker.checker_datas.new
  end

  def create
    @problem = Problem.find(params[:problem_id])
    @checker = @problem.checker
    @checker_data = @checker.checker_datas.new(params[:checker_data])
    if @checker_data.save
      redirect_to problem_checker_path(@problem, @checker)
    else
      render :action => :new
    end
  end

  def destroy
    @problem = Problem.find(params[:problem_id])
    @checker = @problem.checker
    @checker_data = CheckerData.find(params[:id])
    @checker_data.destroy
    redirect_to problem_checker_path(@problem, @checker)
  end
end
