# frozen_string_literal: true

require_relative 'player.rb'

class DumbPlayer < Player
  def initialize
    super()
  end

  def action_phase
    # Do nothing, be dumb
    @actions -= 1
  end

  def buy_order
    %i[treasure_map]
  end
end
