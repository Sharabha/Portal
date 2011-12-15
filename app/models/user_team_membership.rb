class UserTeamMembership < ActiveRecord::Base

  belongs_to :team
  belongs_to :user
validate :ensure_is_space_in_team, :before => :create
  private
  def ensure_is_space_in_team
  id = TeamMembership.find(self.team_id).competition_id
  max_users_property = Competition.find(id).max_users
    if( Team.find(self.id).count >=max_users_property )
	   return false
	   else return true
    end
  end
end

  validates_presence_of :team_id
  validates_presence_of :user_id
end


