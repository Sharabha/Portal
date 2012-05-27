class Problem < ActiveRecord::Base

  belongs_to :author, :class_name => "User"

  has_many :tests

  has_many :solutions
  has_many :teams, :through => :solutions

  has_many :guardian_memberships
  has_many :guardians, :through => :guardian_memberships

  has_many :problem_memberships
  has_many :competitions, :through => :problem_memberships, :dependent => :restrict

  accepts_nested_attributes_for :guardians

  validates :author_id, :presence => true
  validates :name, :length => {:minimum => 3}
  validates :description, :length => {:minimum => 3}
  validates_presence_of :points

  after_create :notify_checker

  attr_protected :author_id
  
  private
    def notify_checker
	  #to be implemented; this function should ask checker for creation of new problem
    end
end
