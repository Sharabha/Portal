class CompetitionsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :except => [:index]

  def index
    current_time = Time.now
    @current_competitions = Competition.where("is_active = ? AND start <= ? AND deadline >= ?", true, current_time, current_time).accessible_by(current_ability)
    @planned_competitions = Competition.where("is_active = ? AND start > ? ", true, current_time).accessible_by(current_ability)
    @archive_competitions = Competition.where("is_active = ? AND deadline < ?", true, current_time).accessible_by(current_ability)
  end

  def show
  end
end
