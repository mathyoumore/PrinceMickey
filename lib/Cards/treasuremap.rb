require_relative 'card.rb'

class TreasureMap < Card
  attr_reader :name, :cost, :vp, :instructions
  def initialize()
    super
    @name = "Treasure Map"
    @cost = 4
    @vp = 0
    @instructions = {:treasure_map => 0}
    @types = [:action]
  end
end
