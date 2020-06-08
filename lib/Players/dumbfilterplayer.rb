# frozen_string_literal: true

require_relative 'player.rb'

class DumbFilterPlayer < Player
  def initialize
    super()
  end

  def buy_order
    %i[treasure_map warehouse]
  end

  def discard_order
    %i[treasure_map estate copper warehouse]
  end

  def action_phase
    if @hand.count_of_card(:warehouse) > 0
      play_action(:warehouse)
    end
  end

  def can_do_actions?
    @actions > 0 && @hand.get_all_of_card(:warehouse).count > 0
  end

  def play_action(action)
    @actions -= 1
    @hand.find_and_play(action)
  end
end
