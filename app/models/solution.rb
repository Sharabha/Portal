#encoding: utf-8
class Solution < ActiveRecord::Base
  belongs_to :team_membership
  belongs_to :problem_membership

  has_one :team, :through => :team_membership
  has_one :problem, :through => :problem_membership
  has_one :competition, :through => :problem_membership

  has_attached_file :code

  validates_uniqueness_of :team_membership_id, :scope => :problem_membership_id, :message => "Już dodałeś rozwiązanie"
  validates_attachment_presence :code, :message => "Musisz dodać plik z kodem rozwiązania"
  validates_presence_of :team_membership_id
  validates_presence_of :problem_membership_id
end
