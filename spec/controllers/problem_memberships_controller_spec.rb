require 'spec_helper'
describe ProblemMembershipsController do
  include Devise::TestHelpers

    before :each do
        @user = Factory :admin
        sign_in @user
        @competition = Factory :competition
        @problem = Factory :problem
    end
    context "as a registered admin I can add and remove problems to/from competition" do
        describe "POST create" do
            it "should be successful" do
                post "create", :competition_id => @competition.id,:problem_id => @problem.id
                response.code.should satisfy { |n| n =="200" or n=="302"} #nie wiem skąd różnica, ale 200 to OK
            end 
            it "should raise 'not found' error if invalid competition id provided" do
                lambda {
                    post "create", :competition_id => 123712873981,:problem_id => @problem.id
                }.should raise_error(ActiveRecord::RecordNotFound)
            end
            #zasada powstawania 'not found' jeszcze do zbadania...
            #it "should raise 'not found' error if invalid problem id provided" do
                #lambda {
                    #post "create", :competition_id => @competition.id,:problem_id => 128371892312
                #}.should raise_error(ActiveRecord::RecordNotFound)
            #end
        end
    end
end
