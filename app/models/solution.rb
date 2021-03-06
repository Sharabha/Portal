#encoding: utf-8
class Solution < ActiveRecord::Base
  belongs_to :team
  belongs_to :problem_membership

  has_many :user_team_memberships, :through => :team
  has_many :team_members, :through => :user_team_memberships, :source => :user
  has_one :problem, :through => :problem_membership
  has_one :competition, :through => :problem_membership

  has_attached_file :code

  validates_uniqueness_of :team_id, :scope => :problem_membership_id, :message => "Już dodałeś rozwiązanie"
  validates_attachment_presence :code, :message => "Musisz dodać plik z kodem rozwiązania"
  validates_presence_of :team_id, :problem_membership_id

  after_create :set_score
  after_save :save_file

  private
    def save_file
      CheckerFile.save_solution(self)
    end

    def set_score
      checker = self.problem.checker
      self.score = checker.check_solution(self) * self.problem.points
      self.save
    end
end
