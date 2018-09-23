require 'swat_game/treasure_trove'

module SwatGame
  describe TreasureTrove do
    before do
      @treasure = Treasure.new(:pie, 5)
    end

    context "when a player gets to the treasure trove" do
      it "has an item with the name of" do
        expect(@treasure.name).to eq(:pie)
      end

      it "has an item with some points" do
        expect(@treasure.points).to eq(5)
      end

      it "receives a random treasure" do
        treasure = TreasureTrove.random
        expect(TreasureTrove::TREASURES).to include(treasure)
      end
    end
  end
end
