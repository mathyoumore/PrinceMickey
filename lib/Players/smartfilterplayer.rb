# frozen_string_literal: true

require_relative 'player.rb'

@warehouseLimit = 0

class SmartFilterPlayer < Player
  def initialize(limit = 10)
    @warehouseLimit = limit
    super()
  end

  def name
    "#{self.class}_#{@warehouseLimit}"
  end

  def buy_order
    if @hand.grand_count_of_card(:warehouse) < @warehouseLimit
      %i[treasure_map warehouse]
    else
      %i[treasure_map warehouse]
    end
  end

  def discard_order
    %i[estate copper warehouse treasure_map]
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

  # def playWarehouse
  #   @hand.draw(3)
  #   @hand.cards.sort!
  #   discardingCards = []
  #   discardingCards << @hand.cards.delete_at(@hand.cards.index(3)) # remove Warehouse, required
  #   if @hand.treasureMapsInDeck < 2 && @hand.cards.index(4)
  #     discardingCards << @hand.cards.delete_at(@hand.cards.index(4)) # remove 1 map, if have it AND I don't have 2 total
  #   end
  #   discardingCards << @hand.cards.shift(4 - discardingCards.size) # delete cards in ascending order of value
  #   if discardingCards.count(3) == 0
  #     p 'STH, no Warehouses found'
  #     pp discardingCards
  #     exit
  #   end
  #   @hand.discardCards(discardingCards.flatten!)
  # end
end
