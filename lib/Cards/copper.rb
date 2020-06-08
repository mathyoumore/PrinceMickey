require_relative 'card.rb'

class Copper < Card
  attr_reader :name, :cost, :vp, :instructions

  def initialize()
    super
    @name = "Copper"
    @cost = 0
    @vp = 0
    @instructions = {:coin => 1}
    @types = [:treasure]
  end
end
