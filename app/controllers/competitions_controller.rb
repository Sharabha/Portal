class CompetitionsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
  end
  def show
    @judge_memberships = @competition.judge_memberships
    @team_memberships = @competition.team_memberships
    @problems = @competition.problems
  end
end
