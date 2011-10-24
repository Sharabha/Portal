class Competition < ActiveRecord::Base
  belongs_to :owner, :class_name => "User"
  validates_presence_of :name
  validates_presence_of :owner_id
  
  has_many :judge_memberships
  has_many :judges, :through => :judge_memberships

  has_many :competitor_memberships
  has_many :competitors, :through => :competitor_memberships
end
