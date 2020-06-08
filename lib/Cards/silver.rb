require_relative 'card.rb'
class Silver < Card
  attr_reader :name, :cost, :vp, :instructions

  def initialize()
    super
    @name = "Silver"
    @cost = 3
    @vp = 0
    @instructions = {:coin => 2}
    @types = [:treasure]
  end
end
