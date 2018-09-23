require 'swat_game/game'
require 'swat_game/die'
require 'swat_game/game_turn'
require 'swat_game/treasure_trove'

module SwatGame
  describe Game do
    before do
      @game = Game.new("Knuckleheads")
      @initial_health = 100
      @player = Player.new("moe", @initial_health)
      @game.add_player(@player)
      $stdout = StringIO.new
    end

    context "dice is rolled" do
      it "w00ts the player if it is a high number" do
        allow_any_instance_of(Die).to receive(:roll).and_return(5)
        @game.play(2)
        expect(@player.health).to eq(@initial_health + (15 * 2))
      end

      it "keeps health the same if it is a medium number" do
        allow_any_instance_of(Die).to receive(:roll).and_return(3)
        @game.play(2)
        expect(@player.health).to eq(@initial_health)
      end

      it "blams the player if it is a low number" do
        allow_any_instance_of(Die).to receive(:roll).and_return(1)
        @game.play(2)
        expect(@player.health).to eq(@initial_health - (10 * 2))
      end
    end

    context "treasure item given during each turn" do
      it "assigns a treasure for points during a player's turn" do
        game = Game.new("Knuckleheads")
        player = Player.new("moe")
        game.add_player(player)
        game.play(1)
        expect(player.points).to_not be_zero
      end
    end

    context "for all treasure found during the game" do
      it "computes total points as the sum of all player points" do
        game = Game.new("Knuckleheads")
        player1 = Player.new("moe")
        player2 = Player.new("larry")
        game.add_player(player1)
        game.add_player(player2)
        player1.found_treasure(Treasure.new(:hammer, 50))
        player1.found_treasure(Treasure.new(:hammer, 50))
        player2.found_treasure(Treasure.new(:crowbar, 400))

        expect(game.total_points).to eq(500)
      end
    end
  end
end
