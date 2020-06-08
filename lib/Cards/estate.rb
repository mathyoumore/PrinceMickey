require_relative 'card.rb'
class Estate < Card
  attr_reader :name, :cost, :vp, :instructions

  def initialize()
    super
    @name = "Estate"
    @cost = 2
    @vp = 1
    @types = [:victory]
  end
end
