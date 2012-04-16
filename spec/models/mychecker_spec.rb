require 'spec_helper'

# This is mostly integration test between two different parts of a project
# Before running this test, make sure that Checker is online with parameters specified in checker.yaml
# There is also planned a version with some kind of checker mock

describe Mychecker do
	before(:each) do
		@checker = Mychecker.new
		@existing_problem_id = 777
		@existing_run_id = 302
		@solution_language = "C++"
		@solution_code = "#include <cstdlib>\n int main(){ printf(\"solution\"); return 0;}"
	end
	it "should load the configuration for #{Rails.env} environment" do
		@checker.getConfiguration.should_not be_nil
	end
	it "should send json requests by default" do
		@checker.checker.headers[:content_type].should== :json
	end
	it "should have connection with online checker" do
		response = @checker.problems.get
		response.code.should == 200
	end
	it "should return exception when problem is not found" do
		lambda{ @checker.problem(444).get }.should raise_error
	end
	it "should return correct json result when resource is found" do
		response = @checker.problem(@existing_problem_id).get
		response.code.should == 200
		response.headers[:content_type].should == "application/json"
		result = JSON.parse(response.body)
		result["id"].should == @existing_problem_id
	end
	it "should create new problem" do
		response = @checker.createProblem
		response.code.should==200
		response.headers[:content_type].should == "application/json"
		result = JSON.parse(response.body)
		result["id"].should_not == nil
	end
	it "should return exception when run is not found" do
		lambda{ @checker.run(@existing_problem_id, 404).get }.should raise_error	
	end
	it "should return correct json run if it is found" do
		response = @checker.run(@existing_problem_id, @existing_run_id).get
		response.code.should == 200
		response.headers[:content_type].should == "application/json"
		result = JSON.parse(response.body)
		result["id"].should == @existing_run_id
	end
	it "should accept and confirm the solution submit with 201 code" do
		response = @checker.submitSolution(@existing_problem_id, @solution_language, @solution_code)
		response.code.should == 201
		response.headers[:content_type].should == "application/json"
		result = JSON.parse(response.body)
		result["id"].should_not == nil	
	end
end
