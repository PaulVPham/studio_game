require_relative 'player'

class ClumsyPlayer < Player
  def initialize(name, health, boost=1)
    super(name, health)
    @boost = boost
  end

  def found_treasure(treasure)
    damaged_treasure = Treasure.new(treasure.name, treasure.points / 2)
    super(damaged_treasure)
  end

  def w00t
    @boost.times { super }
    # runs additional w00ts based on boost number given to ClumsyPlayer
    # calls w00t from Player class still
  end
end

if __FILE__ == $0
  clumsy = ClumsyPlayer.new("klutz", 100, 2)
  hammer = Treasure.new(:hammer, 50)
  clumsy.found_treasure(hammer)
  clumsy.found_treasure(hammer)
  clumsy.found_treasure(hammer)

  crowbar = Treasure.new(:crowbar, 400)
  clumsy.found_treasure(crowbar)

  clumsy.each_found_treasure do |treasure|
    puts "#{treasure.points} total #{treasure.name} points"
  end
    puts "#{clumsy.points} grand total points"

  clumsy.w00t
  clumsy.w00t
  puts clumsy.health
end
