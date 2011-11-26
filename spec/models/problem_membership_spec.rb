require 'spec_helper'
describe ProblemMembership do
  before (:each) do
  end

  it "should not allow to destroy ongoing problem" do
    pending
    problem = ProblemMembership.new(:competition_id => 1, :problem_id => 1, :points => 1, :description => 'description',
                          :start_time => Time.new, :end_time => Time.new + 10.minutes)
    problem.save
    problem.destroy.should be_false
  end

  it "should not allow to create finished problem" do
    pending
    problem = ProblemMembership.new(:competition_id => 1, :problem_id => 1, :points => 1, :description => 'description',
                          :start_time => Time.now - 20.minutes, :end_time => Time.new - 10.minutes)
    problem.save.should be_false
  end

  it "should begin before finish date" do
    pending
    problem = ProblemMembership.new(:competition_id => 1, :problem_id => 1, :points => 1, :description => 'description',
                          :start_time => Time.now, :end_time => Time.new - 10.minutes)
    problem.save.should be_false
  end


end
