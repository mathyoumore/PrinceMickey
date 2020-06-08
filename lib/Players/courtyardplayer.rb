# frozen_string_literal: true

require_relative 'player.rb'

class CourtyardPlayer < Player
  def initialize
    super()
  end

  def buy_phase
    @hand.tryToBuyTreasureMap
    @hand.tryToBuyCourtyard unless @hand.maximumCourtyards?
  end

  def playHand
    super
  end

  def story
    super
  end

  def drawNew
    unless @hand.threeEstates?
      raise "DrawNew Too many estates\n\n#{@hand.summarize}"
    end

    super
  end

  def action_phase
    # puts @hand.splay
    raise "I don't have enough cards" if @hand.cards.size < 5

    if @hand.haveCourtyard?
      if @hand.twoTreasuresInHand?
        endRun
      else
        playCourtyard
      end
    end
  end

  def playCourtyard
    @hand.draw(3) # draw 3
    @hand.cards.sort!
    @hand.play(5) # remove Warehouse
    @hand.topdeckTreasureMapOrWorst
  end
end
