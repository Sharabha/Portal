describe CompetitionsController do
  include Devise::TestHelpers

  before :each do
      @user = Factory :admin
      sign_in @user
  end

  context "as a registered admin I can create and delete competitions" do

    describe "POST create" do
      it "should be successful" do
        post "create", :competition => {:organizer_id => @user.id, :name => 'asasdasd'}
        response.code.should == "302" 
      end 

      it "should raise 'not found' error if invalid organizer id provided" do
        lambda {
        post "create", :competition => {:organizer_id => 123, :name => 'asasdasd'}
    }.should raise_error(ActiveRecord::RecordNotFound)
      end
    end

    describe "POST update" do
      before :each do
        Factory :competition
      end

      it "should be successful" do
        @competition = Competition.first
        post "update", :competition => {:deadline =>  DateTime.now() + 10.minutes, 
                                        :name => 'newname'}, 
                       :id => @competition.id
        response.code.should == "302" 
      end 
    end

    describe "DELETE destroy" do
      before :each do
        5.times do
            Factory :competition
        end
      end

      it "should be successful" do
      	@competition = Competition.first
        delete "destroy", :id => @competition.id
        response.code.should == "302" 
      end

      it "should destroy one competition" do
      	@competition = Competition.first
        lambda {
          delete "destroy", :id => @competition.id
        }.should change(Competition, :count).by(-1)
      end

      it "should raise 'not found' error if invalid user id provided" do
        lambda {
          delete "destroy", :id => 123
        }.should raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
