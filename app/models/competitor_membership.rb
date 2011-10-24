class CompetitorMembership < ActiveRecord::Base
  belongs_to :competitor, :class_name => "User"
  belongs_to :competiton

  validates_presence_of :competitor_id
  validates_presence_of :competition_id
  validates_uniqueness_of :competitor_id, :scope => :competition_id
end
