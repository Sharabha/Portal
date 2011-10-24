class JudgeMembershipsController < ApplicationController
  def new
    @competition = Competition.find(params[:competition_id])
    @judge_membership = @competition.judge_memberships.new
  end

  def create
    @competition = Competition.find(params[:competition_id])
    @judge_membership = @competition.judge_memberships.create(params[:judge_membership])
    if @judge_membership.save
      redirect_to competition_path(@competition)
    else
      render :action => :new
    end
  end
end
