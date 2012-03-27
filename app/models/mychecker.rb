require 'addressable/template'

#Simulates interaction with Checker
class Mychecker
	CONF = CHECKER_CONFIG
	@@headers = {:accept=> :json, :content_type => :json}
	attr_reader :sender
	def initialize
		@sender = Sender.new(host, port)
	end
	def getProblem(problem_id)
		RestClient.get problem_url(problem_id), @@headers
	end
	def createTest(problem_id)
		test = {:test=>{:solution_input=>"spadaj", :checker_input => "spadaj", :time_limit=> 12, :memory_limit=> 1}}
		res = RestClient.post new_problem_test_url(problem_id), test.to_json, @@headers	
	end
	def getProblems
		RestClient.get problems_url
	end
	def createProblem
		RestClient.post new_problem_url, "create_new".to_json, @@headers
	end
	def createRun(problem_id)
		run = {:run=> {:language=> "C", :solution => "main(){;}", :notify => "http://wontbecalledyet"}}
		RestClient.post new_problem_run_url(problem_id), run.to_json, @@headers
	end
	def repeatRun(problem_id, run_id)
		recheck = {:recheck=> {:notify=> "http://uri"}}
		RestClient.post problem_run_url(problem_id, run_id), recheck.to_json, @@headers
	end
	def getRun(problem_id, run_id)
		RestClient.get problem_run_url(problem_id, run_id), @@headers
	end
	def getTest(problem_id, test_id)
		RestClient.get problem_test_url(problem_id, test_id), @@headers
	end
	def deleteRun(problem_id, run_id)
		RestClient.delete problem_run_url(problem_id, run_id), @@headers
	end
	def deleteTest(problem_id, test_id)
		RestClient.delete problem_test_url(problem_id, test_id), @@headers	
	end
	def method_missing(sym, *args, &block)
		if CONF.has_key?(sym.to_s) then
			key = CONF[sym.to_s]
			if sym.to_s.end_with?('url') then
				key = build_url(key,args)
			end
			return key
		end
		super(sym, *args, &block)
	end
	def build_url(url,args)
		if args.any? then
			template = Addressable::Template.new(url)
			mapper = Hash[template.keys.zip args]
			if mapper.has_value?(nil) then
				raise ArgumentError, "not enough non-nil arguments for "+ url
			end
			url = template.expand(mapper).to_s
		end
		protocol + "://"+ host + ":" + port.to_s  + url
	end
end
