# frozen_string_literal: true

require_relative 'player.rb'

class DumbBigMoneyPlayer < Player
  def initialize
    super()
  end

  def action_phase
    # Do nothing, be dumb
    @actions -= 1
  end

  def buy_order
    %i[gold silver]
  end

  #TODO Implement DumbBigMoney, need to update EndRun logic for this player
end
