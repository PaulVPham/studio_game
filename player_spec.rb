require_relative 'player'
require_relative 'treasure_trove'

module SwatGame
  describe Player do
    before do
      @initial_health = 150
      @found_treasures = Hash.new(0)
      @player = Player.new("larry", @initial_health)
      $stdout = StringIO.new
    end

    context "when player name is lowercase" do
      it "has to capitalize name of player" do
        expect(@player.name).to eq("Larry")
      end
    end

    context "player has specific health assigned" do
      it "has an initial health" do
        expect(@player.health).to eq(150)
      end
    end

    context "player greeting output" do
      it "has a string representation" do
        @player.found_treasure(Treasure.new(:hammer,50))
        @player.found_treasure(Treasure.new(:hammer,50))
        expect(@player.to_s).to eq("I'm Larry with health = 150, points = 100, and score 250.")
      end
    end

    context "total current player score" do
      it "computes a score as the sum of its health and points" do
        @player.found_treasure(Treasure.new(:hammer, 50))
        @player.found_treasure(Treasure.new(:hammer, 50))
        score = @initial_health + @found_treasures.values.reduce(0,:+)
        # @player.length would call both name and health, which doesn't work
        expect(@player.score).to eq(250)
      end
    end

    context "player gains more health points" do
      it "increases health by 15 when w00ted" do
        @player.w00t
        expect(@player.health).to eq(@initial_health + 15)
      end
    end

    context "player loses health points" do
      it "decreases health by 10 when blammed" do
        @player.blam
        expect(@player.health).to eq(@initial_health - 10)
      end
    end

    context "with a health greater than 100" do
      before do
        @player = Player.new("larry", 150)
      end

      it "is strong" do
        expect(@player).to be_strong
        #expect(@player.strong?).to eq(true)
      end
    end

    context "with a less than 100" do
      before do
        @player = Player.new("curly", 100)
      end

      it "is wimpy" do
        expect(@player).to_not be_strong #literal false of strong
      end
    end

    context "in a collection of players" do
      before do
        @player1 = Player.new("moe", 100)
        @player2 = Player.new("larry", 200)
        @player3 = Player.new("curly", 300)

        @players = [@player1, @player2, @player3]
      end

      it "is sorted by decreasing score" do
        expect(@players).to contain_exactly(@player3, @player2, @player1)
      end
    end

    context "player finds and stores treasure" do
      it "computes points as the sum of all treasure points" do
        expect(@player.points).to eq(0)
        @player.found_treasure(Treasure.new(:hammer, 50))
        expect(@player.points).to eq(50)
        @player.found_treasure(Treasure.new(:crowbar, 400))
        expect(@player.points).to eq(450)
        @player.found_treasure(Treasure.new(:hammer, 50))
        expect(@player.points).to eq(500)
      end

      it "yields each found treasure and its total points" do
        @player.found_treasure(Treasure.new(:skillet, 100))
        @player.found_treasure(Treasure.new(:skillet, 100))
        @player.found_treasure(Treasure.new(:hammer, 50))
        @player.found_treasure(Treasure.new(:bottle, 5))
        @player.found_treasure(Treasure.new(:bottle, 5))
        @player.found_treasure(Treasure.new(:bottle, 5))
        @player.found_treasure(Treasure.new(:bottle, 5))
        @player.found_treasure(Treasure.new(:bottle, 5))

        yielded = []
        @player.each_found_treasure do |treasure|
          yielded << treasure
        end
        # contain_exactly tests array that doesn't worry about ordering between expected and actual
        expect(yielded).to contain_exactly((Treasure.new(:skillet, 200)), (Treasure.new(:hammer, 50)), (Treasure.new(:bottle, 25)))
      end

    end

    context "file from csv" do
      it "creates a new player from csv string" do
        player = Player.from_csv("larry,150")
        expect(player.name).to eq("Larry")
        expect(player.health).to eq(150)
      end
    end

  end
end
