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
      create_list(:dog_walking, 3, pets: [create(:pet)])

      get '/v1/dog_walkings'

      expect(json_response.size).to eq(3)
    end

    context 'when not_started flag is true' do
      it 'returns only not started walkings' do
        create(:dog_walking,
               start_date: Time.zone.now - 10.minutes,
               pets: [create(:pet)])
        not_started_walking = create(:dog_walking,
                                     start_date: Time.zone.now + 10.minutes,
                                     pets: [create(:pet)])

        get '/v1/dog_walkings', params: { not_started: true }

        expect(json_response.size).to eq(1)
        expect(json_response.first).to include(id: not_started_walking.id)
      end
    end

    context 'when pagination params are provided' do
      it 'returns dog walkings paginated' do
        create_list(:dog_walking, 3, pets: [create(:pet)])

        get '/v1/dog_walkings', params: { page: 2, per_page: 2 }

        expect(json_response.size).to eq(1)
      end

      context 'when not_started flag is true' do
        it 'returns dog walkings paginated' do
          create_list(:dog_walking, 3,
                      appointment_date: Date.today,
                      start_date: Time.now + 10.minutes,
                      pets: [create(:pet)])

          get '/v1/dog_walkings',
              params: { not_started: true, page: 2, per_page: 2 }

          expect(json_response.size).to eq(1)
        end
      end
    end
  end

  describe 'GET /v1/dog_walkings/:id' do
    it 'returns HTTP status 200 OK' do
      dog_walking_id = create(:dog_walking, pets: [create(:pet)]).id

      get "/v1/dog_walkings/#{dog_walking_id}"

      expect(response).to have_http_status(:ok)
    end

    it 'returns a dog walking' do
      dog_walking = create(:dog_walking, pets: [create(:pet)])

      get "/v1/dog_walkings/#{dog_walking.id}"

      expect(json_response).to include(id: dog_walking.id)
    end

    it 'returns all the attributes available in DogWalking' do
      dog_walking = create(:dog_walking, pets: [create(:pet)])

      get "/v1/dog_walkings/#{dog_walking.id}"

      expect(json_response.keys)
        .to eq(dog_walking.attributes.symbolize_keys.keys << :pets)
    end

    it 'returns the true duration of the walk' do
      dog_walking = create(:dog_walking,
                           pets: [create(:pet)],
                           duration: 30,
                           start_date: Time.current - 10.minutes,
                           end_date: Time.current)

      get "/v1/dog_walkings/#{dog_walking.id}"

      expect(json_response[:duration]).to eq(10)
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

  describe 'POST /v1/dog_walkings' do
    before(:each) do
      create(:plan)
    end

    it 'returns HTTP status 201 created' do
      pet = create(:pet)
      dog_walking = build(:dog_walking, pets: [pet])

      post_params = {
        dog_walking: {
          appointment_date: dog_walking.appointment_date,
          duration: dog_walking.duration,
          start_date: dog_walking.start_date,
          end_date: dog_walking.end_date,
          latitude: dog_walking.latitude,
          longitude: dog_walking.longitude,
          pet_ids: [pet.id]
        }
      }

      post '/v1/dog_walkings', params: post_params

      expect(response).to have_http_status(:created)
    end

    it 'creates the dog_walking' do
      pet = create(:pet)
      dog_walking = build(:dog_walking, pets: [pet])

      post_params = {
        dog_walking: {
          appointment_date: dog_walking.appointment_date,
          duration: dog_walking.duration,
          start_date: dog_walking.start_date,
          end_date: dog_walking.end_date,
          latitude: dog_walking.latitude,
          longitude: dog_walking.longitude,
          pet_ids: [pet.id]
        }
      }

      expect { post('/v1/dog_walkings', params: post_params) }
        .to change { DogWalking.count }.by(1)
    end

    it 'returns the created dog walking in json format' do
      pet = create(:pet)
      dog_walking = build(:dog_walking, pets: [pet])

      post_params = {
        dog_walking: {
          appointment_date: dog_walking.appointment_date,
          duration: dog_walking.duration,
          start_date: dog_walking.start_date,
          end_date: dog_walking.end_date,
          latitude: dog_walking.latitude,
          longitude: dog_walking.longitude,
          pet_ids: [pet.id]
        }
      }

      post '/v1/dog_walkings', params: post_params

      expect(json_response).to include(id: DogWalking.last.id)
    end

    context 'when a required attribute is missing' do
      it 'return HTTP status 422 unprocessable entity' do
        dog_walking = build(:dog_walking)

        post_params = {
          dog_walking: {
            appointment_date: dog_walking.appointment_date,
            duration: dog_walking.duration,
            start_date: dog_walking.start_date,
            end_date: dog_walking.end_date,
            latitude: dog_walking.latitude,
            longitude: dog_walking.longitude
          }
        }

        post '/v1/dog_walkings', params: post_params

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a error json response' do
        dog_walking = build(:dog_walking)

        post_params = {
          dog_walking: {
            appointment_date: dog_walking.appointment_date,
            duration: dog_walking.duration,
            start_date: dog_walking.start_date,
            end_date: dog_walking.end_date,
            latitude: dog_walking.latitude,
            longitude: dog_walking.longitude
          }
        }

        post '/v1/dog_walkings', params: post_params

        expect(json_response[:error])
          .to eq(message: "Validation failed: Pets can't be blank")
      end
    end

    context 'when param dog_walking is missing' do
      it 'returns HTTP status 422 unprocessable_entity' do
        post_params = { random_data: 'some random data' }

        post '/v1/dog_walkings', params: post_params

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a error json response' do
        post_params = { random_data: 'some random data' }

        post '/v1/dog_walkings', params: post_params

        expect(json_response[:error])
          .to eq(message: 'param is missing or the value is empty: dog_walking')
      end
    end

    context 'when pet is not found' do
      it 'returns HTTP response 422 unprocessable_entity' do
        dog_walking = build(:dog_walking)
        inexistent_pet_id = 42

        post_params = {
          dog_walking: {
            appointment_date: dog_walking.appointment_date,
            duration: dog_walking.duration,
            start_date: dog_walking.start_date,
            end_date: dog_walking.end_date,
            latitude: dog_walking.latitude,
            longitude: dog_walking.longitude,
            pet_ids: [inexistent_pet_id]
          }
        }

        post '/v1/dog_walkings', params: post_params

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a error json response' do
        dog_walking = build(:dog_walking)
        inexistent_pet_id = 42

        post_params = {
          dog_walking: {
            appointment_date: dog_walking.appointment_date,
            duration: dog_walking.duration,
            start_date: dog_walking.start_date,
            end_date: dog_walking.end_date,
            latitude: dog_walking.latitude,
            longitude: dog_walking.longitude,
            pet_ids: [inexistent_pet_id]
          }
        }

        post '/v1/dog_walkings', params: post_params

        expect(json_response[:error])
          .to eq(message: "Validation failed: Pets can't be blank")
      end
    end
  end

  describe 'PUT /v1/dog_walkings/:id/start_walk' do
    it 'returns HTTP status 200 OK' do
      dog_walking = create(:dog_walking, pets: [create(:pet)])

      put "/v1/dog_walkings/#{dog_walking.id}/start_walk"

      expect(response).to have_http_status(:ok)
    end

    it 'calls DogWalking#start_walk' do
      dog_walking = create(:dog_walking, pets: [create(:pet)])

      allow(DogWalking).to receive(:find).and_return(dog_walking)
      allow(dog_walking).to receive(:start_walk)

      put "/v1/dog_walkings/#{dog_walking.id}/start_walk"

      expect(dog_walking).to have_received(:start_walk)
    end

    context 'when dog walking is not found' do
      it 'returns HTTP status 404 not found' do
        invalid_id = 42

        put "/v1/dog_walkings/#{invalid_id}/start_walk"

        expect(response).to have_http_status(:not_found)
      end

      it 'returns a json error response' do
        invalid_id = 42

        put "/v1/dog_walkings/#{invalid_id}/start_walk"

        expect(json_response[:error])
          .to eq(message: "Couldn't find DogWalking with 'id'=42")
      end
    end
  end

  describe 'PUT /v1/dog_walkings/:id/finish_walk' do
    it 'returns HTTP status 200 OK' do
      dog_walking = create(:dog_walking, pets: [create(:pet)])

      put "/v1/dog_walkings/#{dog_walking.id}/finish_walk"

      expect(response).to have_http_status(:ok)
    end

    it 'calls DogWalking#start_walk' do
      dog_walking = create(:dog_walking, pets: [create(:pet)])

      allow(DogWalking).to receive(:find).and_return(dog_walking)
      allow(dog_walking).to receive(:finish_walk)

      put "/v1/dog_walkings/#{dog_walking.id}/finish_walk"

      expect(dog_walking).to have_received(:finish_walk)
    end

    context 'when dog walking is not found' do
      it 'returns HTTP status 404 not found' do
        invalid_id = 42

        put "/v1/dog_walkings/#{invalid_id}/finish_walk"

        expect(response).to have_http_status(:not_found)
      end

      it 'returns a json error response' do
        invalid_id = 42

        put "/v1/dog_walkings/#{invalid_id}/finish_walk"

        expect(json_response[:error])
          .to eq(message: "Couldn't find DogWalking with 'id'=42")
      end
    end
  end
end
