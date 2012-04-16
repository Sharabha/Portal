require 'addressable/template'

#Responsible for communication between Web Application and Solutions Checker

class Mychecker
	CONF = CHECKER_CONFIG
	def checker_url
		protocol+"://"+host+":"+port.to_s
	end
	def initialize

	end
	def checker
		RestClient::Resource.new checker_url, :headers => {:accept=> :json, :content_type => :json}
	end
	def problems
		checker['/problem']
	end
	def problem(problem_id)
		problems["/"+problem_id.to_s]
	end
	def createTest(problem_id)
		test = {:test=>{:solution_input=>"spadaj", :checker_input => "spadaj", :time_limit=> 12, :memory_limit=> 1}}
		problem(problem_id).post test.to_json	
	end
	def createProblem
		problems.post "create_new".to_json
	end
	def createRun(problem_id)
		run = {:run=> {:language=> "C", :solution => "main(){;}", :notify => notify_path}
		problem(problem_id).post run.to_json
	end
	def run(problem_id, run_id)
		problem(problem_id)["/run/"+run_id.to_s]
	end
	def test(problem_id, test_id)
		problem(problem_id)["/test/"+test_id.to_s]
	end
	def repeatRun(problem_id, run_id)
		recheck = {:recheck=> {:notify=> notify_path}}
		run(problem_id, run_id).post recheck.to_json
	end
	def deleteRun(problem_id, run_id)
		run(problem_id,run_id).delete
	end
	def deleteTest(problem_id, test_id)
		test(problem_id, test_id).delete	
	end
	def method_missing(sym, *args, &block)
		if CONF.has_key?(sym.to_s) then
			return CONF[sym.to_s]
		end
		super(sym, *args, &block)
	end
end
