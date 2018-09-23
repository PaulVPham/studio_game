require_relative 'player'
require_relative 'game'
require_relative 'die'
require_relative 'clumsy_player'
require_relative 'berserk_player'

knuckleheads = SwatGame::Game.new("Knuckleheads")
knuckleheads.load_players(ARGV.shift || "players.csv")
clumsy_player1 = SwatGame::ClumsyPlayer.new("ditz", 105, 3)
knuckleheads.add_player(clumsy_player1)
berserk_player1 = SwatGame::BerserkPlayer.new("turnt", 50)
knuckleheads.add_player(berserk_player1)

loop do
  puts "\nHow many game rounds? ('quit' to exit)"
  answer = gets.chomp.downcase
  case answer
  when /^\d+$/
    knuckleheads.play(answer.to_i)
  when 'quit', 'exit'
    knuckleheads.print_stats
    break
  else
    puts "Please enter a number or 'quit'"
  end
end
knuckleheads.save_high_scores
