class JudgeMembership < ActiveRecord::Base
  belongs_to :judge, :class_name => "User"
  belongs_to :competition

  validates_presence_of :judge_id
  validates_presence_of :competition_id
  validates_uniqueness_of :judge_id, :scope => :competition_id
end
