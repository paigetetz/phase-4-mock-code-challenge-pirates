require 'rails_helper'

RSpec.describe Treasure, type: :model do
  let(:pirate) { Pirate.create(name: "Greenbeard", age: 45) }
  let(:island) { Island.create(name: 'Trinidad') }

  describe 'relationships' do
    it 'can access the associated pirate' do
      treasure =
        Treasure.create(pirate_id: pirate.id, island_id: island.id, contents: "Lots of gold")

      expect(treasure.pirate).to eq(pirate)
    end

    it 'can access the associated island' do
      treasure =
        Treasure.create(pirate_id: pirate.id, island_id: island.id, contents: "Lots of gold")

      expect(treasure.island).to eq(island)
    end
  end

end
