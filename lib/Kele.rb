require "kele/version"
require "httparty"

class Kele
	include HTTParty 

	def initialize(email, password)

		url = "https://www.bloc.io/api/v1/sessions"
		response = self.class.post(url, body: {email: email, password: password})

		@auth_token = response["auth_token"]

	end

	def get_me

		url = 'https://www.bloc.io/api/v1/users/me'
		response = self.class.get(url, headers: {'authorization' => @auth_token})

		@user_data = JSON.parse(response.body)

	end

end
