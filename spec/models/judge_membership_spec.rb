describe JudgeMembership do
  before (:each) do
    @competition = Factory :competition
    @judge_hash = Factory.attributes_for :judge_membership, :competition => @competition
  end

  it{should belong_to :competition}
  it{should belong_to :judge}
  it{should validate_presence_of :competition_id}
  it{should validate_presence_of :judge_id}

  it "should not allow the same judge to be assigned twice" do
    @user = @competition.organizer
    Factory :judge_membership, :competition => @competition, :judge => @user
    @judge = JudgeMembership.new(@judge_hash.merge(:judge => @user))
    @judge.should_not be_valid
  end
    
end
