require 'spec_helper'
require 'matchers/matchers'

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
		@checker.checker.should be_json
	end
	it "should have connection with online checker" do
		response = @checker.problems.get
		response.code.should == 200
	end
	it "should create new problem" do
		response = @checker.createProblem
		response.code.should==200
		response.should be_json
		result = JSON.parse(response.body)
		result["id"].should_not == nil
	end
	it "created problem should be available" do
		response = @checker.createProblem
		problem_id = JSON.parse(response.body)["id"]
		response = @checker.problem(problem_id).get
		problem_id2 = JSON.parse(response.body)["id"]
		problem_id.should == problem_id2
	end
	describe "should return exception when" do
		it "run is not found" do
			lambda{ @checker.run(@existing_problem_id, 404).get }.should raise_error	
		end
		it "problem is not found" do
			lambda{ @checker.problem(444).get }.should raise_error
		end
	end
	describe "should return correct json result when" do	
		it "problem is found" do
			response = @checker.problem(@existing_problem_id).get
			response.code.should == 200
			response.should be_json
			result = JSON.parse(response.body)
			result["id"].should == @existing_problem_id
		end
		it "run is found" do
			response = @checker.run(@existing_problem_id, @existing_run_id).get
			response.code.should == 200
			response.should be_json
			result = JSON.parse(response.body)
			result["id"].should == @existing_run_id
		end
	end
	it "should accept the solution and confirm with 201 code and its data" do
		response = @checker.submitSolution(@existing_problem_id, @solution_language, @solution_code)
		response.code.should == 201
		response.should be_json
		result = JSON.parse(response.body)
		result["id"].should_not == nil	
	end
	it "should accept the test and confirm with 201 code and its data" do
		response = @checker.createTest(@existing_problem_id, "input", "ouput", 128, 10)
		response.code.should == 201
		response.should be_json
		result = JSON.parse(response.body)
		result["id"].should_not == nil
		result["time_limit"].should == 128
		result["memory_limit"].should == 10
	end
end
