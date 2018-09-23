require_relative 'player'
require_relative 'clumsy_player'

module SwatGame
  describe ClumsyPlayer do
    before do
      @player = ClumsyPlayer.new("klutz",100,3)
      $stdout = StringIO.new
    end
    context "treasure points received do" do
      it "only earns half the points from each treasure" do
        expect(@player.points).to eq(0)

        hammer = Treasure.new(:hammer, 50)
        @player.found_treasure(hammer)
        @player.found_treasure(hammer)
        @player.found_treasure(hammer)

        expect(@player.points).to eq(75)

        crowbar = Treasure.new(:crowbar, 400)
        @player.found_treasure(crowbar)

        expect(@player.points).to eq(275)

        yielded = []
        @player.each_found_treasure do |treasure|
          yielded << treasure
        end

        expect(yielded).to contain_exactly(Treasure.new(:hammer, 75), Treasure.new(:crowbar, 200))
      end
    end
  end
end
