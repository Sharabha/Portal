describe Problem do
  before (:each) do
  end

  it{should belong_to :competition}
  it{should have_many :guardians}
  it{should validate_presence_of :competition_id}

  it "should not allow to destroy ongoing problem" do
    problem = Problem.new(:competition_id => 1, :name => 'test', :points => 1, :description => 'description',
                          :start_time => Time.new, :end_time => Time.new + 10.minutes)
    problem.save
    problem.destroy.should be_false
  end

  it "should not allow to create finished problem" do
    problem = Problem.new(:competition_id => 1, :name => 'test', :points => 1, :description => 'description',
                          :start_time => Time.now - 20.minutes, :end_time => Time.new - 10.minutes)
    problem.save.should be_false
  end

  it "should begin before finish date" do
    problem = Problem.new(:competition_id => 1, :name => 'test', :points => 1, :description => 'description',
                          :start_time => Time.now, :end_time => Time.new - 10.minutes)
    problem.save.should be_false
  end


end
