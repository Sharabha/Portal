class Problem < ActiveRecord::Base
  belongs_to :competition
  
  has_many :judge_memberships
  has_many :judges, :through => :judge_memberships
  has_many :judge_users, :source => :user, :through => :judges

  has_many :solutions
  has_many :teams, :through => :solutions
end
