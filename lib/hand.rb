# frozen_string_literal: true

class Hand
  attr_reader :cards, :deck, :playedCardsThisTurn
  def initialize(player)
    @player = player
    @cards = []
    @deck = Deck.new
    @cardFactory = CardFactory.new
    @adjustedCardIndex = 0
    @groupDiscardIndexAdjustment = 0
    @dictionary = {
      0 => 'Estate',
      1 => 'Copper',
      3 => 'Warehouse',
      4 => 'Treasure Map',
      5 => 'Courtyard',
      6 => 'Silver',
      7 => 'Gold'
    }
  end

  def class_from_symbol(sym)
    Kernel.const_get(sym.to_s.split('_').collect(&:capitalize).join)
  end

  def draw(n)
    (@cards << @deck.draw(n)).flatten!
  end

  def actions
    get_all_of_type(:action)
  end

  def treasures
    get_all_of_type(:treasure)
  end

  def get_all_of_type(type)
    typeMatchedCards = []
    @cards.each_with_index do |card, index|
      if !card.nil? && card.types.include?(type)
        typeMatchedCards << { card: card, index: index }
      end
    end
    typeMatchedCards
  end

  def have_actions?
    get_all_of_type(:action).count > 0
  end

  def draw_new
    # puts "\nDrawing new hand"
    discard_hand
    binding.pry if @cards.count != 0
    draw(5)
    if @cards.size < 5
      raise "Hand::draw_new, unexpected hand size: #{@cards.size}"
    end
    @adjustedCardIndex = 0
  end

  def try_to_buy(cardOrder)
    cardOrder = [cardOrder].flatten
    costs = @cardFactory.cost_hash(cardOrder)
    cardOrder.each do |wantedCard|
      if costs[wantedCard] <= @player.coins
        @deck.buy(wantedCard)
        # pp "I bought a Treasure Map on turn #{@player.turns} with #{@player.coins}"
        break
      else
        # pp "I failed to buy a Treasure Map on turn #{@player.turns}"
      end
    end
  end

  def play_all_treasures
    @adjustedCardIndex = 0
    treasures.each do |treasure|
      play(treasure)
      @adjustedCardIndex += 1
    end
  end

  def play(card)
    card[:card].instructions.each do |k, v|
      send(k, v)
    end
    discard_card(card)
  end

  def action(n)
    @player.add_action(n)
  end

  def coin(n)
    @player.add_coin(n)
  end

  def choose_to_discard(countToDiscard)
    discardedCards = 0
    @groupDiscardIndexAdjustment = 0
    @player.discard_order.each do |d|
      get_all_of_card(d).each do |targeted|
        next unless discardedCards < countToDiscard
        find_and_discard(targeted[:card].class)
        discardedCards += 1
      end
      break if discardedCards == countToDiscard
    end
    raise 'Something bad happened' if discardedCards > countToDiscard
  end

  def get_all_of_card(target)
    matches = []
    @cards.each_with_index do |c, i|
      matches << { card: c, index: i } if c.is_a?(class_from_symbol(target))
    end
    matches
  end

  def discard_card(card)
    binding.pry if @cards[card[:index] - @adjustedCardIndex].nil?
    @deck.add_to_discard(@cards.delete_at(card[:index] - @adjustedCardIndex))
  end

  def discard_hand
    @deck.add_to_discard(@cards.pop) while @cards.count > 0
  end

  def count_of_card(card)
    @cards.count { |c| c.is_a?(class_from_symbol(card)) }
  end

  def grand_count_of_card(card)
    get_all_of_card(card).count + @deck.get_all_of_card(card).count
  end

  def grand_count_of_all_cards
    @cards.count + @deck.grand_count_of_all_cards
  end

  def find_and_discard(discardingCard)
    @cards.each_with_index do |c, i|
      if discardingCard.is_a?(Class)
        c.is_a?(discardingCard)
        discard_card({ card: c, index: i })
        break
      elsif c.is_a?(class_from_symbol(discardingCard))
        discard_card({ card: c, index: i })
        break
      end
    end
  end

  def find_and_play(actionCard)
    @cards.each_with_index do |c, i|
      if c.is_a?(class_from_symbol(actionCard))
        play ({ card: c, index: i })
        break
      end
    end
  end

  def summarize
    {
      'Estate' => (get_all_of_card(:estate).count + @deck.count(0)),
      'Copper' => (get_all_of_card(:copper).count + @deck.count(1)),
      'Warehouse' => (get_all_of_card(:warehouse).count + @deck.count(3)),
      'Treasure Map' => (get_all_of_card(:treasure_map).count + @deck.count(4)),
      'Courtyard' => (get_all_of_card(:courtyard).count + @deck.count(5))
    }
  end

  ############################################ vv OLD SHIT vv ############################################
  ############################################ vv OLD SHIT vv ############################################
  ############################################ vv OLD SHIT vv ############################################
  ############################################ vv OLD SHIT vv ############################################
  ############################################ vv OLD SHIT vv ############################################







  def tryToBuyTreasureMap
    raise 'Trying to use old shit'
    if @cards.count(1) >= 4 && (@deck.count(4) + cards.count(4)) < 10
      @deck.buy(4) # Treasure Map
      spendMoney(4)
    end
  end

  def tryToBuyWarehouse
    raise 'Trying to use old shit'
    if @cards.count(1) >= 3 && (@deck.count(3) + cards.count(3)) < 10
      @deck.buy(3) # Treasure Map
      spendMoney(3)
    end
  end

  def tryToBuyBestTreasure
    raise 'Trying to use old shit'
    case wealth
    when 3..5 then tryToBuySilver
    when 6..100 then tryToBuyGold
    end
  end

  def tryToBuySilver
    raise 'Trying to use old shit'
    @deck.buy(6) # silver
    spendMoney(3)
  end

  def tryToBuyCourtyard
    raise 'Trying to use old shit'
    if @cards.count(1) >= 2 && (@deck.count(5) + cards.count(5)) < 10
      @deck.buy(5) # Treasure Map
      spendMoney(2)
    end
  end

  def haveCourtyard?
    raise 'Trying to use old shit'
    @cards.count(5) > 0
  end

  def treasureMapsInDeck
    raise 'Trying to use old shit'
    @deck.count(4)
  end

  def topdeckTreasureMapOrWorst
    raise 'Trying to use old shit'
    if treasureMapsInDeck >= 2 && @cards.count(4) > 0
      @deck.topdeck(@cards.delete_at(@cards.index(4)))
    else
      @deck.topdeck(@cards.sort!.shift)
      raise "Didn't work, too many cards" unless @cards.size == 6
    end
  end

  def maximumCourtyards?
    raise 'Trying to use old shit'
    @deck.count(5) >= 10
  end

  def deckOrder
    raise 'Trying to use old shit'
    @deck.reveal
  end

  def splay
    raise 'Trying to use old shit'
    "#{@deck}\nContents of Hand: #{hashify(@cards)}"
  end

  def hashify(set)
    raise 'Trying to use old shit'
    uniques = set.uniq.sort
    hashed = {}
    uniques.each do |v|
      hashed[@dictionary[v]] = set.count(v)
    end
    hashed.to_s
  end
end
