#decides how exactly works sending
class Sender
	attr_reader :default_header
	attr_writer :default_header
	def initialize(host, port, root_path="")
		@host = host
		@port = port
		@root_path = root_path
		@default_header={}
	end
	def prepareGet(path, params={})
		w = Net::HTTP::Get.new(@root_path + path)
		@default_header.each_pair {|k, v| w[k]=v}
		return w
	end
	def get(path, params={})
		w = prepareGet(path, params)
		res = Net::HTTP.start(@host, @port) { |http| http.request(w) }
	end
end
