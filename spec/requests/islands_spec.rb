require 'rails_helper'

RSpec.describe 'Islands', type: :request do
  before do
    Island.create(name: 'A')
    Island.create(name: 'B')
  end

  describe 'GET /islands' do
    it 'returns an array of all islands' do
      get '/islands'

      expect(response.body).to include_json(
        [
          {
            id: a_kind_of(Integer),
            name: 'A'
          },
          {
            id: a_kind_of(Integer),
            name: 'B'
          },
        ],
      )
    end

    it 'returns a status of 200 (OK)' do
      get '/islands'

      expect(response).to have_http_status(:ok)
    end
  end
end
