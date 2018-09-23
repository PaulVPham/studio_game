module SwatGame
  module Playable

    def strong?
      self.health > 100
    end

    def blam
      self.health -= 10
      puts "#{self.name} got blammed!"
    end

    def w00t
      self.health += 15
      puts "#{self.name} got w00ted!"
    end

  end
  
end
