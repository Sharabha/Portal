class TeamMembership < ActiveRecord::Base
  belongs_to :team
  belongs_to :competition

  validates_presence_of :team_id
  validates_presence_of :competition_id
  validates_uniqueness_of :team_id, :scope => :competition_id
end
