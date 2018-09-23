require_relative 'player'
require_relative 'game_turn'
require_relative 'die'
require_relative 'treasure_trove'

module SwatGame
  class Game
    attr_reader :title

    def initialize(title)
      @title = title
      @players = []
    end

    def load_players(from_file)
      File.readlines(from_file).each do |line|
        add_player(Player.from_csv(line))
      end
    end

    def save_high_scores(to_file="high_scores.txt")
      File.open(to_file, "w") do |file|
        file.puts "#{@title} High Scores:" #specify that output will be in txt and not console/terminal
        @players.sort.each do |player|
          file.puts high_score_entry(player)
        end
      end
    end

    def high_score_entry(player)
      player_name_format = player.name.ljust(15, '.')
      "#{player_name_format} #{player.score}"
    end

    def add_player(new_player)
      @players << new_player
    end

    def print_name_and_health(player)
      puts "#{player.name} (#{player.health})"
    end

    def total_points
      @players.reduce(0) { |sum, player| sum + player.points }
      #since it's a hash, the key and value have to be called
    end

    def play(rounds)
      puts "There are #{@players.size} in #{@title}:"
      @players.each do |w|
        puts w
      end

      treasure_items = TreasureTrove::TREASURES
      puts "\nThere are #{treasure_items.count} treasures to be found:"
      treasure_items.each do |treasure|
        puts "A #{treasure.name} is worth #{treasure.points} points"
      end

      1.upto(rounds) do |count|
        puts "\nRound #{count}: "
        @players.each do |w|
          GameTurn.take_turn(w)
          puts w
        end
      end
    end

    def print_stats
      puts "\n#{@title} Statistics:"
      strong, wimpy = @players.partition { |player| player.health > 100 }

      puts "\n#{strong.count} strong players:"
      strong.each do |player|
        print_name_and_health(player)
      end

      puts "\n#{wimpy.count} wimpy players:"
      wimpy.each do |player|
        print_name_and_health(player)
      end

      puts"\nIndividual Player Points Earned:"
      @players.each do |player|
        puts "#{player.name}'s point totals:"
        player.each_found_treasure do |treasure|
          puts "#{treasure.points} total #{treasure.name} points"
        end
        puts "#{player.points} grand total points"
        puts "\n"
      end

      puts"\nTotal Treasure Points:"
      puts "#{total_points} total points from treasures found"

      puts "\n#{@title} High Scores:"
      @players.sort.each do |player|
        puts high_score_entry(player)
      end
    end

  end
end
