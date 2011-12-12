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

    can :manage, Competition, :organizer_id=>user.id

    # organizator zawodów może podpiąć sędziów do zawodów
    can :create, JudgeMembership do |judge_membership|
      puts "\n\n\n\n\n\n=============>#{judge_membership.inspect}"
      judge_membership.competition.organizer_id == user.id
    end

    # sędzia zawodów może podpiąć zadanie do zawodów
    can :create, ProblemMembership do |problem| #sedzia
        problem.competition.judge_memberships.any?{|x| user.id==x.judge_id}
    end

    # 
  end
end
