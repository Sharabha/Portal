require 'spec_helper'

describe CheckerDatasController do
  include Devise::TestHelpers
  
  context "as an admin user I want to be able to manage things to be checked" do
    before :each do
      @user = Factory :user
      sign_in @user
      @problem_membership = Factory :problem_membership
      @problem = @problem_membership.problem
      @competition = @problem_membership.competition
      @checker = Factory :checker, :problem => @problem
    end

    describe "POST create" do
      before :each do 
        @cd_hash = Factory.attributes_for :checker_data, :checker => @checker
      end
      
      it "should be successful" do
        post 'create', :problem_id => @problem.id, :checker => @cd_hash
        response.status.should == 302
      end

      it "should create one new checker data" do
        lambda {
          post 'create', :problem_id => @problem.id, :checker => @cd_hash
        }.should change(CheckerData, :count).by(1)
      end

      it "should be possible to add multiple data" do
        lambda {
	  5.times do
            post 'create', :problem_id => @problem.id, :checker => @cd_hash
          end
        }.should change(CheckerData, :count).by(5)
      end
    end

    describe "DELETE destroy" do
      before :each do 
        @checker_data = Factory :checker_data, :checker => @checker
      end
      
      it "should be successful" do
        delete 'destroy', :problem_id => @problem.id, :id => @checker_data.id
        response.status.should == 302
      end

      it "should delete one checker data" do
        lambda {
        delete 'destroy', :problem_id => @problem.id, :id => @checker_data.id
        }.should change(CheckerData, :count).by(-1)
      end
    end
  end
end
