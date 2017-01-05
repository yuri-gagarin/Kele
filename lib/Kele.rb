require "kele/version"
require "httparty"
require "json"


class Kele
	include HTTParty 

	def initialize(email, password)

		response = self.class.post(api_url('sessions'), body: {email: email, password: password})

		return @auth_token = response["auth_token"]

	end

	def get_me

		response = self.class.get(api_url('users/me'), headers: {'authorization' => @auth_token})
		return @user_data = JSON.parse(response.body)

	end

	def get_mentor_availability

		my_info = self.get_me
		mentor_id = my_info['current_enrollment']['mentor_id']

		response = self.class.get(api_url('mentors/#{mentor_id}/student_availability'), headers: {'authorization' => @auth_token})

		return response.body


	end


	private

	def api_url(location)

		return "https://www.bloc.io/api/v1/#{location}"
	end



end
