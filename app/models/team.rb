class Team < ActiveRecord::Base
  belongs_to :leader, :class_name=>"User"

  #wait, what?
  #belongs_to :competitions
 # has_many :team_memberships
  has_one :team_membership
  has_many :user_team_memberships
  has_many :competitions, :through => :team_memberships
  has_many :users
  validates_presence_of :leader_id
  validates_presence_of :name
end
