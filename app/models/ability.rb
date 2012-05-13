class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.has_role?(:admin)
      can :manage, :all
    elsif user.has_role?(:organizer)
      #ORGANIZATOR
      can :manage, Competition, :organizer_id => user.id

      can :manage, JudgeMembership, :competition => { :organizer_id => user.id }

      can :read, Problem

      can :manage, TeamMembership, :competition => { :organizer_id => user.id }

      can :delete, ProblemMembership, :competition => { :organizer_id => user.id }

      can :manage, Solution, :competition => { :organizer_id => user.id }
    elsif user.has_role?(:guardian)
      #SEDZIA
      can :read, Problem

      can :create, ProblemMembership, :competition => { :judges => { :id => user.id } }

      can :read, Competition, :judges => { :id => user.id }

      #sedzia czyta tulko zadania z zawodów
      can :read, ProblemMembership, :problem => { :competition => { :judges => { :id => user.id } } }
    else
      #ZAWODNIK
      can :read, Competition

      can :read, ProblemMembership, :competition => { :teams => { :leader_id => user.id } }
      can :read, ProblemMembership, :competition => { :team_members => { :id => user.id } }

      can :manage, Solution, :team => { :leader_id => user.id }
      can :manage, Solution, :team_members => { :id => user.id }

      can :manage, Team, :leader_id => user.id
      can :read, Team, :team_members => { :id => user.id }

      can :read, UserTeamMembership, :team => { :team_members => { :id => user.id } }
      can :read, UserTeamMembership, :team => { :leader_id => user.id }

      can :index, Invitation
      can :manage, Invitation, :team => { :leader_id => user.id }

      #NOBODY
      can :index, Competition
    end
  end
end
