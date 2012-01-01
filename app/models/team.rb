class Team < ActiveRecord::Base
  belongs_to :leader, :class_name=>"User"

  has_many :invitations
  has_one  :team_membership
  has_many :user_team_memberships
  has_many :team_members, :through => :user_team_memberships, :source => :user
  has_many :competitions, :through => :team_memberships
  has_many :users
  validates_presence_of :leader_id
  validates_presence_of :name
end
