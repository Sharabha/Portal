require 'spec_helper'
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
    expect {
        Factory :judge_membership, :competition => @competition, :judge => @user
    }.should raise_error
  end
    
end
