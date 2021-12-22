require 'rails_helper'

RSpec.describe Pirate, type: :model do
  describe 'relationships' do
    let(:island) { Island.create(number: 1, date: '1/11/99') }
    let(:pirate) { Pirate.create(name: 'Bruce McCulloch', occupation: 'actor') }

    it 'can access the associated treasures' do
      treasure =
        Treasure.create(guest_id: pirate.id, island_id: island.id, content: "Gold")

      expect(pirate.treasures).to include(treasure)
    end

    it 'can access the associated islands' do
      Treasure.create(guest_id: pirate.id, island_id: island.id, content: "Gold")

      expect(pirate.islands).to include(island)
    end
  end

  describe 'validations' do
    it 'must have a name' do
      expect(
        Pirate.create(
          name: "Blackbeard",
          age: 17,
        ),
      ).to be_invalid
      expect(
        Pirate.create(
          age: 20,
        ),
      ).to be_invalid
    end

    it 'must have an age between 18 and 100' do
      expect(
        Pirate.create(
          name: "Blackbeard",
          age: 18,
        ),
      ).to be_valid
      expect(
        Pirate.create(
          name: "Blackbeard",
          age: 18,
        ),
      ).to be_valid
      expect(
        Pirate.create(
          name: "Blackbeard",
          age: 100,
        ),
      ).to be_valid
      expect(
        Pirate.create(
          name: "Blackbeard",
          age: 35,
        ),
      ).to be_valid
      expect(
        Pirate.create(
          name: "Blackbeard",
          age: 101,
        ),
      ).to be_invalid
    end
  end

end
