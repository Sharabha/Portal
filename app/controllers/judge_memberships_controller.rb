class JudgeMembershipsController < ApplicationController
  load_and_authorize_resource :except => [:show,:new,:create]#TODO: co z create?

  def show
    @competition = Competition.find(params[:competition_id])
    @judge_membership = @competition.judge_memberships.find(params[:id])
  end

  def new
    @competition = Competition.find(params[:competition_id])
    @judge_membership = @competition.judge_memberships.new
    authorize! :new, @judge_membership #<- ważne
  end

  def create
    @competition = Competition.find(params[:competition_id])
    @judge_membership = @competition.judge_memberships.create(params[:judge_membership])
    authorize! :create, @judge_membership #<- ważne

    if @judge_membership.save
      redirect_to competition_path(@competition)
    else
      render :action => :new
    end
  end

  def destroy
    @competition = Competition.find(params[:competition_id])
    @judge_membership = @competition.judge_memberships.find(params[:id])
    @judge_membership.destroy
    redirect_to competition_path(@competition)
  end
end
