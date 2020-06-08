require_relative 'card.rb'
class Courtyard < Card
  attr_reader :name, :cost, :vp, :instructions

  def initialize()
    super
    @name = "Courtyard"
    @cost = 2
    @vp = 0
    @instructions = {:draw => 3, :topdeck => 1}
    @types = [:action]
  end
end
