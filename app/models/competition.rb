class Competition < ActiveRecord::Base
  belongs_to :organizer, :class_name => "User"
  validates_presence_of :name
  validates_presence_of :organizer_id
  
  has_many :judge_memberships
  has_many :judges, :through => :judge_memberships

  has_many :team_memberships
  has_many :teams, :through => :team_memberships

  has_many :problem_memberships
  has_many :problems, :through => :problem_memberships

  after_create   :organizer_is_judge
  before_destroy :not_started?
  before_save    :deadline_not_expired?

  def organizer_is_judge
    JudgeMembership.create(:judge_id => self.organizer_id, :competition_id => self.id)
  end 
  def started?
    if self.start
      self.start <= DateTime.now
    end
  end
  def not_started?
    if self.start
      !(self.start <= DateTime.now)
    end
  end
  def deadline_not_expired?
    if self.deadline 
      !(self.deadline <= DateTime.now and self.start < self.deadline)
    end
  end
  def deadline_expired?
    if self.deadline 
      self.deadline <= DateTime.now
    end
  end
end
