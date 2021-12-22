require 'rails_helper'

RSpec.describe 'Treasures', type: :request do
  before do
    Pirate.create(name: "Zincbeard", age: 30)
    Island.create(name: 'Tortuga')
  end

  describe 'POST /treasures' do
    context 'with valid data' do
      let(:treasure_params) do
        { pirate_id: Pirate.first.id, island_id: Island.first.id, contents: "Gold" }
      end

      it 'creates a new treasure' do
        expect { post '/treasures', params: treasure_params }.to change(
          Treasure,
          :count,
        ).by(1)
      end

      it 'returns the associated pirate and island data' do
        post '/treasures', params: treasure_params

        expect(response.body).to include_json(
          {
            id: a_kind_of(Integer),
            contents: "Gold",
            pirate: {
              id: a_kind_of(Integer),
              name: 'Zincbeard',
              age: 30,
            },
            island: {
              id: a_kind_of(Integer),
              name: 'Tortuga',
            },
          },
        )
      end

      it 'returns a status code of 201 (created)' do
        post '/treasures', params: treasure_params

        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid data' do
      let!(:invalid_treasure_params) do
        { contents: "Gold", pirate_id: 0, island_id: 0 }
      end

      it 'does not create a new treasure' do
        expect {
          post '/treasures', params: invalid_treasure_params
        }.to change(Treasure, :count).by(0)
      end

      it 'returns the error messages' do
        post '/treasures', params: invalid_treasure_params

        expect(response.body).to include_json({ errors: a_kind_of(Array) })
      end

      it 'returns a status code of 422 (Unprocessable Entity)' do
        post '/treasures', params: invalid_treasure_params

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
