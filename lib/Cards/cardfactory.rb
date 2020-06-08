# frozen_string_literal: true

class CardFactory
  CARDS = {
    copper: {
      cost: 0,
      vp: 0,
      instructions: [{ coin: 1 }],
      types: [:treasure]
    },
    silver: {
      cost: 3,
      vp: 0,
      instructions: [{ coin: 2 }],
      types: [:treasure]
    },
    gold: {
      cost: 6,
      vp: 0,
      instructions: [{ coin: 3 }],
      types: [:treasure]
    },
    estate: {
      cost: 2,
      vp: 2,
      instructions: []
    },
    warehouse: {
      cost: 3,
      vp: 0,
      instructions: [{ draw: 3, action: 1, discard: 3 }]
    },
    courtyard: {
      cost: 2,
      vp: 0,
      instructions: [{ draw: 3, topdeck: 1 }]
    },
    treasure_map: {
      cost: 4,
      vp: 0,
      instructions: [{ treasure_map: 0 }]
    }
  }.freeze

  def initialize
    @kingdom = {
      warehouse: 10,
      treasure_map: 10,
      courtyard: 10
    }
  end

  def buy(card)
    # This living disaster of clever coding returns a new ### << Card based on
    # the symbol passed in. You have been warned.
    @kingdom[card] = @kingdom[card] - 1
    Kernel.const_get(card.to_s.split('_').collect(&:capitalize).join).new
  end

  def can_buy?(card)
    @kingdom[card] > 0
  end

  def cost_hash(cards)
    costs = {}
    cards.each do |i|
      costs[i] = CARDS[i][:cost]
    end
    costs
  end
end
