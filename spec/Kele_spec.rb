require 'spec_helper'


describe Kele, type: :request do

	context '.kele' do

		let ('kele') { Kele.new(ENV['MY_LOGIN'], ENV['MY_PASSWORD']) }

		describe '#initialize' do
			it 'does not return @auth_token with invalid credentials' do
				response = Kele.new(ENV['MY_LOGIN'], "fakefake") 
				expect(response.instance_variable_get(:@auth_token)).to be_nil
			end

			it 'authenticates user' do
				response = Kele.new(ENV['MY_LOGIN'], ENV['MY_PASSWORD'])
				expect(response.instance_variable_get(:@auth_token)).to_not be_nil
			end
		end

		describe '#get_me' do
			it 'returns an object' do
				expect(kele.get_me).to be_a(Object)
			end
		end

		describe '#get_mentor_availability' do
			it 'returns an object' do
				expect(kele.get_mentor_availability).to be_a(Object)
			end
		end

		describe '#get_roadmap' do
			it 'returns an object' do
				expect(kele.get_roadmap).to be_a(Object)
			end

			it 'has keys within the object' do
				roadmap = kele.get_roadmap
				roadmap_keys = ['id', 'name', 'slug', 'projects']
				roadmap_keys.each do |key|
					expect(roadmap).to include(key)
				end
			end
		end

		describe '#get_checkpoint' do
			it 'returns an object' do
				expect(kele.get_checkpoint(2256)).to be_a(Object)
			end

			it 'has keys within the object' do
				checkpoint = kele.get_checkpoint(2256)
				checkpoint_keys = ['name', 'summary', 'points', 'project_name', 'roadmap_id']
				checkpoint_keys.each do |key|
					expect(checkpoint).to include(key)
				end
			end
		end

		describe '#get_messages' do
			it 'returns an object' do
				expect(kele.get_messages).to be_a(Object)
			end

			it 'has keys within the object' do
				messages = kele.get_messages
				messages_keys = ['id', 'name', 'slug', 'projects']
				messages_keys.each do |key|
					expect(messages).to include(key)
				end
			end
		end
	end
end
