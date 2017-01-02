require 'spec_helper'
require 'figaro'

describe Kele, type: :request do

	context '.kele' do
		describe '#initialize' do
			it 'does not return @auth_token with invalid credentials' do
				response = Kele.new(ENV['MY_LOGIN'], "fakefake") 
				expect(response.instance_variable_get(:@auth_token)).to be_nil
			end

			it 'authenticates user' do
				response = Kele.new(ENV['MY_LOGIN]'], ENV['MY_PASSWORD'])
				expect(response.instance_variable_get(:@auth_token)).to_not be_nil
			end
		end

		describe '#get_me' do
			it 'returns an oject' do
				response = Kele.new(ENV['MY_LOGIN]'], ENV['MY_PASSWORD'])
				expect(response.get_me).to be_a(Object)
			end
		end
	end
end
