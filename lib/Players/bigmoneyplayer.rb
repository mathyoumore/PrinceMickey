# frozen_string_literal: true

require_relative 'player.rb'

class BigMoneyPlayer < Player
  def initialize
    super()
  end

  def action_phase
    # Do nothing, be dumb
  end

  def buy_phase
    @hand.tryToBuyBestTreasure
  end
end
