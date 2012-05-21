#responsible for communication between Web Application and Solutions Checker
#based on RestClient (https://github.com/archiloque/rest-client)

class Mychecker
	def checker_url
		protocol+"://"+host+":"+port.to_s
	end
	def initialize
		setConfiguration(CHECKER_CONFIG)
	end
	def getConfiguration
		@configuration
	end
	def setConfiguration(configuration)
		@configuration= configuration
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
	def createTest(problem_id, input, output, time_limit, memory_limit)
		test = {:test=>{:solution_input=> input, :checker_input => output, :time_limit=> time_limit, :memory_limit=> memory_limit} }
		problem(problem_id).post test.to_json
	end
	def createProblem
		problems.post "create_new".to_json
	end
	def submitSolution(problem_id, language, solution)
		run = {:run=> {:language=> language, :solution => solution, :notify => notify_path}}
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
		if !@configuration.nil? and @configuration.has_key?(sym.to_s) then
			return @configuration[sym.to_s]
		end
		super(sym, *args, &block)
	end
	def to_s
		name = @configuration["name"]
		url = checker_url
		name = "UNKNOWN" if name.nil?
		url = "UNKNOWN" if url.nil?
		"<Checker: " + name + " | url: " + url + "\> "
	end
end
