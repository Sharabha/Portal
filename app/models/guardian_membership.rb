class GuardianMembership < ActiveRecord::Base
  belongs_to :guardian, :class_name => "User"
  belongs_to :problem

  validates_presence_of :guardian_id
  validates_presence_of :problem_id
end
