class Competition < ActiveRecord::Base
  belongs_to :organizer, :class_name => "User"
  validates_presence_of :organizer_id
  validate :deadline, :after_start
  validates :name, :length=> { :minimum => 5, :maximum=> 80 }
  validates :is_active, :needs_confirmation, :inclusion => { :in => [true, false] }

  has_many :judge_memberships
  has_many :judges, :through => :judge_memberships

  has_many :teams
  has_many :user_team_memberships, :through => :teams
  has_many :team_members, :through => :user_team_memberships, :source => :user

  has_many :problem_memberships
  has_many :problems, :through => :problem_memberships
  
  has_many :posts
  
  after_create   :organizer_is_judge

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
    if self.deadline and self.start
      ((self.deadline >= DateTime.now) and (self.start <= self.deadline))
    end
  end
  def deadline_expired?
    if self.deadline and self.start
      ((self.deadline <= DateTime.now) and (self.start <= self.deadline))
    end
  end
  def after_start
	if deadline and start and deadline < start
	  errors.add(:deadline, :later_than_start)
	end
  end
end
