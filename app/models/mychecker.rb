require 'addressable/template'

#Simulates interaction with Checker
class Mychecker
	CONF = CHECKER_CONFIG
	attr_reader :sender
	def initialize
		@sender = Sender.new(host, port)
		@sender.default_header['accept'] = 'application/json'
	end
	def getProblem(problem_id)
		sender.get problem_url(:problem_id=>problem_id)
	end
	def getProblems
		sender.get problems_url
	end
	def getProblemRun(problem_id, run_id)
		sender.get problem_run_url(:problem_id => problem_id, :run_id => run_id)
	end
	def method_missing(sym, *args, &block)
		if CONF.has_key?(sym.to_s) then
			key = CONF[sym.to_s]
			if sym.to_s.end_with?('url') and args.any? then
				return Addressable::Template.new(key).expand(args.first).to_s
			end
			return key
		end
		super(sym, *args, &block)
	end
end
