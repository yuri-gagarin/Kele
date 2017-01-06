module Roadmap

	def get_roadmap

		my_info = self.get_me
		roadmap_id = my_info['current_enrollment']['roadmap_id']
		response = self.class.get(api_url("roadmaps/#{roadmap_id}"), headers: {'authorization' => @auth_token})

		return @roadmap = JSON.parse(response.body)
	end

	def get_checkpoint(number)

		response = self.class.get(api_url("checkpoints/#{number}"), headers: {'authorization' => @auth_token})

		return @checkpoint = JSON.parse(response.body)
	end

end