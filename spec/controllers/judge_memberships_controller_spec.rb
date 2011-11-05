describe JudgeMembershipsController do
  include Devise::TestHelpers

  before :each do
      @user = Factory :admin
      sign_in @user
  end

  context "as a registered admin I can assign people to be judges of competitions" do
    before :each do
      @competition = Factory :competition
      5.times do 
        Factory :user
      end
    end

    describe "POST create" do
      it "should be successful" do
      	@user = User.first
        @judge_membership = {:judge_id => @user.id}
        post "create", :competition_id => @competition.id, :judge_membership => @judge_membership
        response.code.should == "302" 
      end 
      
      it "should assign user as judge to competition" do
        lambda {
      	  @user = User.first
          @judge_membership = {:judge_id => @user.id}
          post "create", :competition_id => @competition.id, :judge_membership => @judge_membership
	}.should change(@competition.judges, :count).by(1)
      end  

      it "should allow to assign many judges to competition" do
        users = User.all
	length = users.length
        lambda {
	  length.times do
      	    user = users.pop
	    judge_membership = {:judge_id => user.id}
	    post "create", :competition_id => @competition.id, :judge_membership => judge_membership
	  end
	}.should change(@competition.judges, :count).by(length)
      end

      it "should raise 'not found' error if invalid competition id provided" do
        lambda {
	  @judge_membership = {:judge_id => @user.id}
	  post "create", :competition_id => 123, :judge_membership => @judge_membership
	}.should raise_error(ActiveRecord::RecordNotFound)
      end

    end

    describe "DELETE destroy" do
      before :each do
        5.times do
	  Factory :judge_membership, :competition => @competition
        end
      end

      it "should be successful" do
      	@judge_membership = JudgeMembership.first
        delete "destroy", :competition_id => @competition.id, :id => @judge_membership.id
        response.code.should == "302" 
      end

      it "should destroy one judge membership" do
        lambda {
      	  @judge_membership = JudgeMembership.first
	  delete "destroy", :competition_id => @competition.id, :id => @judge_membership.id
	}.should change(@competition.judges, :count).by(-1)
      end

      it "should raise 'not found' error if invalid competition id provided" do
        lambda {
      	  @judge_membership = JudgeMembership.first
	  delete "destroy", :competition_id => 123, :id => @judge_membership.id
	}.should raise_error(ActiveRecord::RecordNotFound)
      end

      
    end

  end

end
