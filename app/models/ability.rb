class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
      can :make_admin, :user
      can :remove_admin, :user
    else
      can :read, :all
    end
    can :manage, Competition, :organizer_id=>user.id  #organizator

    can :create, ProblemMembership do |probmem| #sedzia
        probmem.competition.judge_memberships.include? user.id
    end
  end
end
