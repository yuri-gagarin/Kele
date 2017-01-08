require "kele/version"
require "httparty"
require "json"
require 'kele/roadmap'


class Kele
	include HTTParty 
	include Roadmap

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

		response = self.class.get(api_url("mentors/#{mentor_id}/student_availability"), headers: {'authorization' => @auth_token})

		return @mentor_availability = JSON.parse(response.body)


	end

	def get_messages(page=1)

		response = self.class.get(api_url("message_threads?page=#{page}"), headers: {'authorization' => @auth_token})

		return @messages = JSON.parse(response.body)
	end


		
	def create_message(assignment_branch, assignment_commit_link, checkpoint_id, comment, enrollment_id)
    	options = {body: {assignment_branch: assignment_branch, assignment_commit_link: assignment_commit_link, checkpoint_id: checkpoint_id, comment: comment, enrollment_id: enrollment_id}, headers: { "authorization" => @auth_token }}
    	return response = self.class.post(api_url("checkpoint_submissions"), options)
  	end
	

	private

	def api_url(location)

		return "https://www.bloc.io/api/v1/#{location}"
	end



end
