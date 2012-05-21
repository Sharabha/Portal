class Team < ActiveRecord::Base
  belongs_to :leader, :class_name=>"User"
  belongs_to :competition

  has_many :invitations, :dependent => :destroy
  has_many :user_team_memberships, :dependent => :destroy
  has_many :team_members, :through => :user_team_memberships, :source => :user
  has_many :users

  validates_presence_of :leader_id, :name, :competition_id

  attr_protected :leader_id, :admin_id
end
