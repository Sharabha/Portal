class Ability
  include CanCan::Ability

  #TODO: teams
  #TODO: user_team_membership

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
          problem.competition.judges.any?{|x| user.id==x.id}
        end

        #sedzia czyta zawody którym sędziuje
        can :read, Competition do |comp|
          comp.judge_ids.include? user.id
        end

        #sedzia czyta tulko zadania z zawodów
        can :read, ProblemMembership do |problem_membership|
          problem_membership.problem.competition.judges.any?{|x| user.id==x.id}
        end

        #TODO sędzia przegląda tylko zespoły zapisane w zawodach
        #can :read, Team do |team|
        #  team.competition.judge.any?{|x| user.id == x.id}
        #end

        
        # INFO: sędzia nie musi się zajmować członkostwami w zespole
        # -- od tego jest przywódca zespołu

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

        #TODO organizator zarządza zespołami zapisanymi na zawody
        #can :manage, Team do |team|
        # team.competition.organizer_id == user.id
        #end
        
        #zarządza rozwiązaniami z zawodów w których uczestniczy
        can :manage, Solution do |solution|
          solution.competition.organizer_id == user.id
        end

        # INFO: organizator nie musi się zajmować członkostwami w zespole
        # -- od tego jest przywódca zespołu

    else
        #ZAWODNIK
        #przegląda zawody w których uczestniczy
        can :read, Competition do |comp|
          comp.teams.any?{|t| t.leader_id==user.id}
        end

        can :read, Competition do |comp|
          comp.team_members.any?{|u| u.id == user.id}
        end
        
        #przegląda zadania w zawodach w których uczestniczy
        can :read, ProblemMembership do |problem_membership|
          problem_membership.competition.teams.any?{|t| t.leader_id==user.id}
        end

        can :read, ProblemMembership do |problem_membership|
          problem_membership.competition.team_members.any?{|u| u.id == user.id}
        end

        #zarządza rozwiązaniami z zawodów w których uczestniczy
        can :manage, Solution do |solution|
          solution.team.leader_id == user.id
        end

        can :manage, Solution do |solution|
          solution.team_members.any?{|u| u.id == user.id }
        end

        #zakladanie zespolu
        can :create, Team

        #zawodnik czyta nazwę zespołu
        can :read, Team do |team|
          team.team_members.any?{|u| u.id == user.id}
        end
        
        #leader zarządza zespołem
        can :manage, Team do |team|
          team.leader_id == user.id
        end

        #zawodnik czyta członkostwa zespołu
        can :read, UserTeamMembership do |user_team_m|
          user_team_m.team_team.team_members.any?{|u| u.id == user.id}
        end

        #leader zarządza członkostwami zespołu
        can :manage, UserTeamMembership do |user_team_m|
          user_team_m.team.leader_id == user.id
        end

        #NOBODY
        can :index, Competition
    end

  end
end
