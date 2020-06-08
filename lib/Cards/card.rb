class Card
  attr_reader :name, :cost, :vp, :instructions, :types

  def initialize()
    @name = ""
    @cost = 0
    @vp = 0
    @instructions = {}
  end
end
