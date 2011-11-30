class UserTeamMembership < ActiveRecord::Base

  belongs_to :team
  belongs_to :user

  validates_presence_of :team_id
  validates_presence_of :user_id
end


