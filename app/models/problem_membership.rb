class ProblemMembership < ActiveRecord::Base

  belongs_to :problem
  belongs_to :competition

  has_many :solutions

  has_many :guardian_memberships, :dependent => :destroy
  has_many :guardians, :through => :guardian_memberships

  validates :problem_id, :presence => true
  validates :competition_id, :presence => true
  validates :problem_id, :uniqueness => {:scope => :competition_id}
  validate :end_time, :after_start
  def started?
    self.start_time < DateTime.now if self.start_time
  end
  def ended?
    self.end_time < DateTime.now if self.end_time
  end
  def underway?
    self.started? && !self.ended?
  end

  def start_time_before_end_time?
    if self.end_time and self.start_time and self.end_time <= self.start_time
      errors[:start_time] = "must be before end time"
      false
    end
  end
  def after_start
	if end_time and start_time and end_time < start_time
	  errors.add(:end_time, :later_than_start)
	end
  end
end
