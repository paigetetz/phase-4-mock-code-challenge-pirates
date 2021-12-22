require 'rails_helper'

RSpec.describe 'pirates', type: :request do
  before do
    p1 = Pirate.create(name: "Bronzebeard", age: 30)
    p2 = Pirate.create(name: "Mauvebeard", age: 30)
    i1 = Island.create(name: 'Island A')
    i2 = Island.create(name: 'Island B')

    Treasure.create(island_id: i1.id, pirate_id: p1.id, contents: "Stuff")
    Treasure.create(island_id: i2.id, pirate_id: p1.id, contents: "Things")
    Treasure.create(island_id: i1.id, pirate_id: p2.id, contents: "Items")
  end

  describe 'GET /pirates' do
    it 'returns an array of all pirates' do
      get '/pirates'

      expect(response.body).to include_json(
        [
          { id: a_kind_of(Integer), name: "Bronzebeard", age: 30 },
          { id: a_kind_of(Integer), name: "Mauvebeard", age: 30 },
        ],
      )
    end

    it 'does not return any nested islands' do
      get '/pirates'

      expect(response.body).not_to include_json([{ islands: a_kind_of(Array) }])
    end

    it 'returns a status of 200 (OK)' do
      get '/pirates'

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /pirates/:id' do
    context 'with a valid ID' do
      it 'returns the matching pirate with its associated islands' do
        get "/pirates/#{Pirate.first.id}"

        expect(response.body).to include_json(
          {
            id: a_kind_of(Integer),
            name: "Bronzebeard",
            age: 30,
            islands: [
              {
                id: a_kind_of(Integer),
                name: 'Island A',
              },
              {
                id: a_kind_of(Integer),
                name: 'Island B',
              },
            ],
          },
        )
      end

      it 'returns a status of 200 (OK)' do
        get "/pirates/#{Pirate.first.id}"

        expect(response).to have_http_status(:ok)
      end
    end

    context 'with an invalid ID' do
      it 'returns an error message' do
        get '/pirates/bad_id'

        expect(response.body).to include_json({ error: 'Pirate not found' })
      end

      it 'returns the appropriate HTTP status code' do
        get '/pirates/bad_id'

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'DELETE /pirates/:id' do
    context 'with a valid ID' do
      it 'deletes the pirate' do
        expect { delete "/pirates/#{Pirate.first.id}" }.to change(
          Pirate,
          :count,
        ).by(-1)
      end

      it 'deletes the associated treasures' do
        expect { delete "/pirates/#{Pirate.first.id}" }.to change(
          Treasure,
          :count,
        ).by(-2)
      end
    end

    context 'with an invalid ID' do
      it 'returns an error message' do
        delete '/pirates/bad_id'

        expect(response.body).to include_json({ error: 'Pirate not found' })
      end

      it 'returns the appropriate HTTP status code' do
        delete '/pirates/bad_id'

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
