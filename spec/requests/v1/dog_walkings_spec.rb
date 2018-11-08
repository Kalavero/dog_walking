# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'dog_walkings API' do
  include JSONHelpers

  describe 'GET /v1/dog_walkings' do
    it 'returns HTTP status 200 OK' do
      get '/v1/dog_walkings'

      expect(response).to have_http_status(:ok)
    end

    it 'returns all dog_walkings' do
      create_list(:dog_walking, 3)

      get '/v1/dog_walkings'

      expect(json_response.size).to eq(3)
    end

    context 'when not_started flag is true' do
      it 'returns only not started walkings' do
        create(:dog_walking,
               start_time: Time.now - 10.minutes,
               appointment_date: Date.today )
        not_started_walking = create(:dog_walking,
                                     start_time: Time.now + 10.minutes,
                                     appointment_date: Date.today)

        get '/v1/dog_walkings', params: { not_started: true }

        expect(json_response.size).to eq(1)
        expect(json_response.first).to include(id: not_started_walking.id)
      end
    end

    context 'when pagination params are provided' do
      it 'returns dog walkings paginated' do
        create_list(:dog_walking, 3)

        get '/v1/dog_walkings', params: { page: 2, per_page: 2 }

        expect(json_response.size).to eq(1)
      end

      context 'when not_started flag is true' do
        it 'returns dog walkings paginated' do
          create_list(:dog_walking, 3,
                      appointment_date: Date.today,
                      start_time: Time.now + 10.minutes)

          get '/v1/dog_walkings',
            params: { not_started: true, page: 2, per_page: 2 }

          expect(json_response.size).to eq(1)
        end
      end
    end
  end

  describe 'GET /v1/dog_walkings/:id' do
    it 'returns HTTP status 200 OK' do
      dog_walking_id = create(:dog_walking).id

      get "/v1/dog_walkings/#{dog_walking_id}"

      expect(response).to have_http_status(:ok)
    end

    it 'returns a dog walking' do
      dog_walking = create(:dog_walking)

      get "/v1/dog_walkings/#{dog_walking.id}"

      expect(json_response).to include(id: dog_walking.id)
    end

    it 'returns all the attributes available in DogWalking' do
      dog_walking = create(:dog_walking)

      get "/v1/dog_walkings/#{dog_walking.id}"

      expect(json_response.keys)
        .to eq(dog_walking.attributes.symbolize_keys.keys)
    end

    context 'when DogWalking is not found' do
      it 'returns HTTP status 400 not found' do
        invalid_id = 45

        get "/v1/dog_walkings/#{invalid_id}"

        expect(response).to have_http_status(:not_found)
      end

      it 'returns the error in json format' do
        invalid_id = 45

        get "/v1/dog_walkings/#{invalid_id}"

        expect(json_response[:error])
          .to eq(message: "Couldn't find DogWalking with 'id'=#{invalid_id}")
      end
    end
  end
end
