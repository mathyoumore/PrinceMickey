# frozen_string_literal: true

class Player

  attr_reader :deckStory, :coins, :hand, :actions, :turns

  def initialize
    @turnsNeeded = {}
    @turns = 0
    @deckStory = []
    @actionCards = []
    @treasureCards = []
    @coins = 0
    @actions = 0
    @buys = 0
    reset
    draw_new
  end

  def name
    self.class.to_s
  end

  def reset
    @hand = Hand.new(self)
    @turns = 0
    openingBuys
  end

  def openingBuys
    2.times do
      draw_new
      buy_phase
    end
  end

  def draw_new
    @turns += 1
    @coins = 0
    @actions = 1
    @buys = 1
    @hand.draw_new
  end

  def buy_phase
    @hand.play_all_treasures
    @hand.try_to_buy(buy_order) if can_buy?
    @buys -= 1
  end

  def buy_order
    fail "Player::buy_order; Abstract player has no buy order, you goblin"
  end

  def discard_order
    fail "Player::discard_order; Abstract player has no discard order, you ogre"
  end

  def notFinished?(runs)
    progress < runs
  end

  def progress
    return 0 if @turnsNeeded.values.empty?
    @turnsNeeded.values.inject(:+)
  end

  def add_coin (coin)
    @coins += coin
  end

  def add_action(action)
    @actions += action
  end

  def endRun
    @turnsNeeded[@turns] ? @turnsNeeded[@turns] += 1 : @turnsNeeded[@turns] = 1
    reset
  end

  def playHand
    if @hand.count_of_card(:treasure_map) >= 2
      endRun
    else
      while(can_do_actions? && @hand.have_actions?)
        action_phase
      end
      buy_phase
      draw_new
    end
  end

  def can_do_actions?
    @actions > 0
  end

  def can_buy?
    @buys > 0
  end

  def sort_cards
    @actions = @hand.actions
    @treasure = @hand.treasures
  end

  def action_phase
    p "Base Player has no actions phase, you snot heap (Base::action_phase)"
  end

  def story
    sortedHash = {}
    @turnsNeeded.keys.sort.each do |k|
      sortedHash[k] = @turnsNeeded[k]
    end
    sortedHash
  end
end
