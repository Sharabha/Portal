class Problem < ActiveRecord::Base

  belongs_to :author, :class_name => "User"

  has_many :solutions
  has_many :teams, :through => :solutions

  has_many :guardian_memberships
  has_many :guardians, :through => :guardian_memberships

  has_many :problem_memerships
  has_many :competitions, :through => :problem_memerships

  accepts_nested_attributes_for :guardians

  validates :author_id, :presence => true
  validates :name, :length => {:minimum => 3}
  validates :description, :length => {:minimum => 3}
  validates_presence_of :points

  has_one :checker

  after_create :make_checker

  private
    def make_checker
      self.create_checker
    end
end
