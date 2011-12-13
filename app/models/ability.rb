class Ability
  include CanCan::Ability

  #TODO: solution
  #TODO: teams,user_team_membership

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
        can :manage, :all
        can :make_admin, :user
        can :remove_admin, :user
    elsif JudgeMembership.any?{|x| user.id==x.judge_id}
        #SEDZIA
        # moze czytac wszystkie zadania
        can :read, Problem

        # zawodów może podpiąć zadanie do zawodów którym sędziuje
        can :create, ProblemMembership do |problem|
            problem.competition.judge_memberships.any?{|x| user.id==x.judge_id}
        end

        #sedzia czyta zawody którym sędziuje
        can :read, Competition do |comp|
            comp.judge_ids.include? user.id
        end
    elsif Competition.any? {|x| user.id==x.organizer_id}
        #ORGANIZATOR
        #zarządza swoimi zawodami
        can :manage, Competition, :organizer_id=>user.id

        # może podpiąć sędziów do swoich zawodów
        can :manage, JudgeMembership do |judge_membership|
          judge_membership.competition.organizer_id == user.id
        end

        # organizator moze czytac wszystkie zadania
        if Competition.any?{|x| user.id==x.organizer_id}
            can :read, Problem
        end
        # organizator zarzadza druzynami w swoich zawodach
        can :manage, TeamMembership do |team_membership|
          team_membership.competition.organizer_id == user.id
        end

        # tylko organizator moze usuwac zadania
        can :delete, ProblemMembership do |problem|
            problem.competition.organizer_id == user.id
        end
    else
        #ZAWODNIK
        #przeglada zadania z zawodow w ktorych uczestniczy
        can :read, Competition do |comp|
            comp.teams.any?{|t| t.leader_id==user.id or t.user_team_memberships.any?{|m| m.user_id==user.id}}
        end
        
        #NOBODY
        can :index, Competition
    end
  end
end
