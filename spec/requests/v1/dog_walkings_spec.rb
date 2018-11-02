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
  end
end
