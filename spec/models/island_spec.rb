require 'rails_helper'

RSpec.describe Island, type: :model do
  describe 'relationships' do
    let(:pirate) { Pirate.create(name: "Greenbeard", age: 45) }
    let(:island) { Island.create(name: 'Trinidad') }

    it 'can access the associated treasures' do
      treasure =
        Treasure.create(pirate_id: pirate.id, island_id: island.id, contents: "Plenty of gold")

      expect(island.treasures).to include(treasure)
    end

    it 'can access the associated pirates' do
      Treasure.create(pirate_id: pirate.id, island_id: island.id, contents: "Plenty of gold")

      expect(island.pirates).to include(pirate)
    end
  end

  describe 'validations' do
    it 'must have a name' do
      expect(
        Island.create(
          name: "Trinidad"
        ),
      ).to be_valid
      expect(
        Island.create(),
      ).to be_invalid
    end
  end
end
