class CheckerController < ApplicationController
  def show
    @problem = Problem.find(params[:problem_id])
    @checker = @problem.checker
  end
end
