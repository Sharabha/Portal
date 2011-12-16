class UserTeamMembership < ActiveRecord::Base

  belongs_to :team
  belongs_to :user

  validates_presence_of :team_id
  validates_presence_of :user_id

  before_create :ensure_is_space_in_team

  private
  def ensure_is_space_in_team
    debugger
    id = TeamMembership.find_by_team_id(self.team_id).competition_id
    max_users_property = Competition.find(id).max_users
    @user_team_memberships = UserTeamMembership.find_all_by_team_id(self.team_id)
    if @user_team_memberships and @user_team_memberships.count >= max_users_property
	   return false
	else 
		return true
    end
  end

end

