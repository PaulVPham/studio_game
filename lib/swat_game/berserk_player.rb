require_relative 'player'

module SwatGame
  class BerserkPlayer < Player
    def initialize(name, health)
      super(name, health)
      @w00t_counter = 0
    end

    def berserk?
      @w00t_counter > 5
    end

    def w00t
      super
      @w00t_counter += 1
      puts "#{@name} is berserk!" if berserk?
    end

    def blam
      berserk? ? w00t : super
    end

  end

  if __FILE__ == $0
    berserker = BerserkPlayer.new("berserker", 50)
    6.times { berserker.w00t }
    2.times { berserker.blam }
    puts "#{berserker.health} health"
  end
end
