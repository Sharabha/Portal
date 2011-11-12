class Competition < ActiveRecord::Base
  belongs_to :organizer, :class_name => "User"
  validates_presence_of :name
  validates_presence_of :organizer_id
  
  has_many :judge_memberships
  has_many :judges, :through => :judge_memberships

  has_many :competitor_memberships
  has_many :competitors, :through => :competitor_memberships

  has_many :problems

  after_create :organizer_is_judge

  def organizer_is_judge
    JudgeMembership.create(:judge_id => self.organizer_id, :competition_id => self.id)
  end
end
