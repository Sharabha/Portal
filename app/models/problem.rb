class Problem < ActiveRecord::Base

  belongs_to :competition

  has_many :judge_memberships
  has_many :judges, :through => :judge_memberships
  has_many :judge_users, :source => :user, :through => :judges

  has_many :solutions
  has_many :teams, :through => :solutions

  has_many :guardian_memberships
  has_many :guardians, :through => :guardian_memberships

  accepts_nested_attributes_for :guardians

  validates_presence_of :competition_id

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
    !self.ended?
  end

  def underway?
    self.started? && !self.ended?
  end

  def not_underway?
    !self.underway?
  end

  def start_time_before_end_time?
    self.end_time - self.start_time > 0 
  end

end
