require_relative 'card.rb'
class Warehouse < Card
  attr_reader :name, :cost, :vp, :instructions

  def initialize()
    super
    @name = "Warehouse"
    @cost = 3
    @vp = 0
    @instructions = {:draw => 3, :action => 1, :choose_to_discard => 3}
    @types = [:action]
  end
end
