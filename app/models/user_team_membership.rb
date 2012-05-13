class UserTeamMembership < ActiveRecord::Base

  belongs_to :team
  belongs_to :user

  validates_presence_of :team_id
  validates_presence_of :user_id

  before_create :ensure_is_space_in_team

  private
    def ensure_is_space_in_team
      UserTeamMembership.where(:team_id => self.team_id).count < self.team.competition.max_users
    end
end

