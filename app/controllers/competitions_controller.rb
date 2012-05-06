class CompetitionsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    current_time = Time.now
    @current_competitions = Competition.where("is_active = ? AND start <= ? AND deadline >= ?", true, current_time, current_time)
    @planned_competitions = Competition.where("is_active = ? AND start > ? ", true, current_time)
    @archive_competitions = Competition.where("is_active = ? AND deadline < ?", true, current_time)
  end
  def show
    @team_memberships = @competition.team_memberships
    @problems = @competition.problems
  end
end
