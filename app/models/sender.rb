#decides how exactly works sending
class Sender
	def initialize(host, port, root_path="")
		@host = host
		@port = port
		@root_path = root_path
	end
	def get(path, params={})
		w = Net::HTTP::Get.new(@root_path + path)
		w['accept']='application/json'
		res = Net::HTTP.start(@host, @port) { |http| http.request(w) }
	end
end
