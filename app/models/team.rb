class Team < ActiveRecord::Base
  belongs_to :leader, :class_name=>"User"
  belongs_to :competitions
  validates_presence_of :leader_id
  validates_presence_of :name
end
