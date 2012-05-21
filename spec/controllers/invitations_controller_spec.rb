require 'spec_helper'

describe InvitationsController do
  include Devise::TestHelpers

  before :each do
    @user = Factory :user 
    @team = Factory :team
    @competition = Factory :competition
    @team_membership = TeamMembership.new({
        :competition_id => @competition.id,
        :team_id        => @team.id
    })
    @team_membership.save
    sign_in @user
  end

  context "as a logged user I can create and confirm invitation" do

    describe "POST create" do
      it "should be successful" do
        post :create, :team_id => @team, 
                      :invitation => {:user_id => @user.id, :team_id => @team.id}
        response.code.should == "302" 
      end

      it "should raise 'not found' error if invalid team id provided" do
        lambda {
        post :create, :team_id => 123, 
                      :invitation => {:user_id => @user.id, :team_id => 123}
        }.should raise_error(ActiveRecord::RecordNotFound)
      end
    end

    describe "GET confirm" do
      it "should add user as team member" do
        post :create, :team_id => @team, 
                      :invitation => {:user_id => @user.id, :team_id => @team.id}
        @invitation = Invitation.last
        get :confirm, {:token => @invitation.token}
        @team = Team.find(@invitation.team_id)
        @team.team_members.should include(@user)
      end

    end

  end
end
