require_relative 'card.rb'
class Gold < Card
  attr_reader :name, :cost, :vp, :instructions

  def initialize()
    super
    @name = "Gold"
    @cost = 6
    @vp = 0
    @instructions = {:coin => 3}
    @types = [:treasure]
  end
end
