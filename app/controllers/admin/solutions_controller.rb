#encoding: utf-8
class Admin::SolutionsController < Admin::AdminController
  inherit_resources
  nested_belongs_to :competition, :problem_membership
  actions :all, :except => [:index]
  load_and_authorize_resource
  before_filter :authenticate_user!
  before_filter :authenticate_team_leader, :except => [:show]
  before_filter :prepare_params, :only => [:create, :update]

  def create
    create!(:notice => "Dodano rozwiązanie")
  end

  def update
    update!(:notice => "Zmieniono rozwiązanie")
  end

  protected
    def authenticate_team_leader
      team = @competition.teams.where(:leader_id => current_user.id).first
      if team.blank?
        flash[:alert]  = "Tylko lider zespołu może zgłaszać rozwiązanie"
        redirect_to competition_problem_membership_path(@competition, @problem_membership)
      end
    end

    def prepare_params
      resource.team_membership = @competition.team_memberships.find_by_team_id(@competition.teams.where(:leader_id => current_user.id))
    end
end
