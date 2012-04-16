class ProblemMembership < ActiveRecord::Base

  belongs_to :problem
  belongs_to :competition

  has_many :solutions

  has_many :guardian_memberships, :dependent => :destroy
  has_many :guardians, :through => :guardian_memberships

  validates :problem_id, :presence => true
  validates :competition_id, :presence => true
  validates :problem_id, :uniqueness => {:scope => :competition_id}

  # ever heard of validate?
  before_save :start_time_before_end_time?
  before_save :not_ended?
  before_destroy :not_underway?

  def started?
    self.start_time < DateTime.now if self.start_time
  end

  def ended?
    self.end_time < DateTime.now if self.end_time
  end

  def not_ended?
    if self.ended?
      errors[:end_time] = "must be before current time"
      false
    end
  end

  def underway?
    self.started? && !self.ended?
  end

  def not_underway?
    if self.underway?
      errors[:base] = "can't remove ongoing problem"
      false
    end
  end

  def start_time_before_end_time?
    if self.end_time and self.start_time and self.end_time <= self.start_time
      errors[:start_time] = "must be before end time"
      false
    end
  end

end
