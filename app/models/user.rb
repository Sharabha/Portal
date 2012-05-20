class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :login, :first_name, :last_name, :tshirt_size, :nick

  has_many :organized_competitions, :as => :organizer

  has_many :judge_memberships, :as => :judge
  has_many :judged_competitions, :through => :judge_memberships
  #has_many :competitions, :as => :competitor

  has_many :user_team_memberships
  has_many :user_team_memberships, :as => :team_member

  has_many :invitations

  has_many :user_roles
  has_many :roles, :through => :user_roles

  has_many :posts

  validates_presence_of :first_name
  validates_inclusion_of :tshirt_size, :in => Settings.tshirt_sizes

  def lead_teams
    Team.where(:leader_id => self.id)
  end

  def has_role?(role)
    self.roles.map(&:name).include?(role.to_s)
  end

  def display_name
    "#{first_name}#{nick.blank? ? '' : %Q! "#{nick}"!} #{last_name}"
  end
end
