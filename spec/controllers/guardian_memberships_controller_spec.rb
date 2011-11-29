require 'spec_helper'
describe GuardianMembershipsController do
  include Devise::TestHelpers

  before :each do
      @user = Factory :admin
      sign_in @user
  end

  context "as a registered admin I can assign guardian to problem of competition" do
    before :each do
      @user = User.first
      @problem_membership  = Factory :problem_membership
      @problem_membership.start_time = DateTime.now()
      @problem_membership.end_time = DateTime.now() + 10.minutes
      5.times do 
        Factory :user
      end
    end

    describe "POST create" do
      it "should be successful" do
        @problem_membership.start_time = DateTime.now()
        @problem_membership.end_time = DateTime.now() + 10.minutes
        post "create", :competition_id => @problem_membership.competition_id, 
                       :problem_membership_id => @problem_membership.id,
                       :guardian_membership => { 
                         :problem_membership_id => @problem_membership.id,
                         :guardian_id => @user.id}
        response.code.should == "302" 
      end 
      
      it "should assign guardian to problem membership" do
        lambda {
        @problem_membership.start_time = DateTime.now()
        @problem_membership.end_time = DateTime.now() + 10.minutes
        post "create", :competition_id => @problem_membership.competition_id, 
                       :problem_membership_id => @problem_membership.id,
                       :guardian_membership => { 
                         :problem_membership_id => @problem_membership.id,
                         :guardian_id => @user.id}
	    }.should change(@problem_membership.guardians, :count).by(1)
      end  
    end

    describe "DELETE destroy" do
      it "should be successful" do
        @guardian_membership = GuardianMembership.create(
                       :problem_membership_id => @problem_membership.id,
                       :guardian_id => @user.id
        )
        delete "destroy", :competition_id => @problem_membership.competition.id, 
                          :problem_membership_id => @problem_membership.id,
                          :id => @guardian_membership.id
        response.code.should == "302" 
      end

      #it "should destroy one guardian membership" do
      #  lambda {
      #    @guardian_membership = GuardianMembership.create(
      #                 :problem_membership_id => @problem_membership.id,
      #                 :guardian_id => @user.id
      #    )
      #    delete "destroy", :competition_id => @problem_membership.competition.id, 
      #                      :problem_membership_id => @problem_membership.id,
      #                      :id => @guardian_membership.id
	  #  }.should change(@problem_membership.guardians, :count).by(-1)
      #end

      it "should raise 'not found' error if invalid competition id provided" do
        lambda {
          @guardian_membership = GuardianMembership.create(
                         :problem_membership_id => @problem_membership.id,
                          :problem_membership_id => @problem_membership.id,
                         :guardian_id => @user.id
          )
          delete "destroy", :competition_id => 123,
                            :problem_membership_id => @problem_membership.id,
                            :id => @guardian_membership.id
	    }.should raise_error(ActiveRecord::RecordNotFound)
      end

      
    end

  end

end
