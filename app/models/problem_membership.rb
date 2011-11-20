class ProblemMembership < ActiveRecord::Base
  belongs_to :problem
  belongs_to :competition

  validates_presence_of :problem_id
  validates_presence_of :competition_id
  validates_uniqueness_of :problem_id, :scope => :competition_id
end
