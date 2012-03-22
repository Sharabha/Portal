require 'addressable/template'

#decides how exactly works sending
class Sender
	def get(path, params={})
		begin
			w = RestClient.get path, params
			w.response
		rescue => w
			w.response
		end
	end
	def get2(host, path, params={})
		w = Net::HTTP::Get.new(path)
		res = Net::HTTP.start(host, 80) { |http|
			http.request(w)
		}
	end
	def testMe
		c = MyChecker.new
		c.getProblem 123
	end
end

#Simulates interaction with Checker
class MyChecker
	CONF = CHECKER_CONFIG
	attr_reader :sender, :path, :problem_path
	def initialize
		loadConfiguration
		@sender = Sender.new
	end
	def loadConfiguration
		@protocol = ""
		@path = "www.wp.pl"
		@problem_path = Addressable::Template.new(CONF['problem_path']).expand(:problem_id=>3).to_s
	end
	def getProblem(problem_id)
		get problem_path + problem_id.to_s
	end
	def get(resource_path)
		sender.get path+resource_path 
	end
	def method_missing(sym, *args, &block)
		if CONF.has_key?(sym.to_s) then
			key = CONF[sym.to_s]
		end
		super(sym, *args, &block)
	end
end
