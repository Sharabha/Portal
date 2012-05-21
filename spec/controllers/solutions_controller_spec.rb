require 'spec_helper'

describe SolutionsController do
  include Devise::TestHelpers

  context "as a registered team leader I want to be able to manage problem solutions" do

    before :each do
      @user = Factory :user
      sign_in @user
      @problem_membership = Factory :problem_membership
      @problem = @problem_membership.problem
      @competition = @problem_membership.competition

      @team_membership = Factory :team_membership, :competition => @competition
      @team = @team_membership.team
      @team.update_attributes({:leader => @user})
    end

    describe "POST create" do

      before :each do
        @solution_hash = Factory.attributes_for :solution, :team_membership => nil, :problem_membership => nil
      end

      it "should be successful" do
        post 'create', :problem_membership_id => @problem_membership.id, :competition_id => @competition.id, :solution => @solution_hash
        response.status.should == 302
      end

      it "should create one solution" do
      lambda {
        post 'create', :problem_membership_id => @problem_membership.id, :competition_id => @competition.id, :solution => @solution_hash
      }.should change(Solution, :count).by(1)
      end

    end

    describe "PUT update" do

      before :each do
        @solution = Factory :solution, :problem_membership => @problem_membership, :team_membership => @team_membership
      end

      it "should be successful" do
        put 'update', :problem_membership_id => @problem_membership.id, :competition_id => @competition.id, :id => @solution.id, :solution => {:description => "new description"}
        response.status.should == 302
      end

      it "should update solution" do
        put 'update', :problem_membership_id => @problem_membership.id, :competition_id => @competition.id, :id => @solution.id, :solution => {:description => "new description"}
        @solution.reload
        @solution.description.should == "new description"
      end

      it "should not create new solution" do
      lambda {
        put 'update', :problem_membership_id => @problem_membership.id, :competition_id => @competition.id, :id => @solution.id, :solution => {:description => "new description"}
      }.should_not change(Solution, :count)
      end


    end

    describe "DELETE destroy" do

      before :each do
        @solution = Factory :solution, :problem_membership => @problem_membership, :team_membership => @team_membership
      end

      it "should be successful" do
        delete 'destroy', :problem_membership_id => @problem_membership.id, :competition_id => @competition.id, :id => @solution.id
        response.status.should == 302
      end

      it "should delete one solution" do
      lambda {
        delete 'destroy', :problem_membership_id => @problem_membership.id, :competition_id => @competition.id, :id => @solution.id
      }.should change(Solution, :count).by(-1)
      end

    end



  end
end
