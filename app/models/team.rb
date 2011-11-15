class Team < ActiveRecord::Base
  belongs_to :users, :class_name=>"User"
  belongs_to_many :competitions
  validates_presence_of :team_id
  validates_presence_of :competition_id
  validates_presence_of :leader_id
  validates_presence_of :name
  validates_numericality_of :team_id
  validates_numericality_of :leader_id
  validates_numericality_of :competition_id
end
