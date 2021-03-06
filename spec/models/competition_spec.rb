require 'spec_helper'
describe Competition do
  before (:each) do
    @competition = Factory :competition
  end

  it{should belong_to :organizer}
  it{should validate_presence_of :name}
  it{should validate_presence_of :organizer_id}

  it "should allow to destroy unstarted competition" do
    competition = Competition.create( 'organizer_id' => 1, 'name' => 'test', 
                                      :start => (DateTime.now() + 10.minutes),
                                      :deadline => (DateTime.now() + 20.minutes))
    competition.save
    competition.destroy.should be_true
  end

  it "should not allow to destroy started competition" do
    competition = Competition.create( 'organizer_id' => 1, 'name' => 'test', 
                                      'start' => DateTime.now() - 10.minutes,
                                      'deadline' => DateTime.now() + 20.minutes)
    competition.save
    competition.destroy.should be_false
  end

  it "should not allow to create finished competition" do
    competition = Competition.new( 'organizer_id' => 1, 'name' => 'test', 
                                   'start' => DateTime.now() - 20.minutes,
                                   'deadline' => DateTime.now() - 10.minutes)
    competition.save.should be_false
  end

  it "should add organizer as a judge" do
    JudgeMembership.find(@competition.id).should_not be_nil
  end
    
end
