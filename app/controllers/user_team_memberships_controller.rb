class UserTeamMembershipsController < ApplicationController

  load_and_authorize_resource :only => :destroy

  def destroy
    if @user_team_membership.team.team_members.count > 1
      @user_team_membership.destroy
    else
      flash[:error] = I18n.t(:team_cannot_be_empty)
    end
    redirect_to @user_team_membership.team
  end

end
