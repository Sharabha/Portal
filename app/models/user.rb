class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_protected :admin

  has_many :organized_competitions, :as => :organizer

  has_many :judge_memberships, :as => :judge
  has_many :judged_competitions, :through => :judge_memberships
  #has_many :competitions, :as => :competitor 
  #has_many :judged_competitions, :as => :judge

  has_many :user_team_memberships
 # has_many :teams, as => leader

  def lead_teams
    Team.where(:leader_id => self.id)
  end

end
