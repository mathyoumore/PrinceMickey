# frozen_string_literal: true

class Deck
  def initialize
    @contents = new_deck
    @discard = []
    @dictionary = {
      0 => 'Estate',
      1 => 'Copper',
      3 => 'Warehouse',
      4 => 'Treasure Map',
      5 => 'Courtyard',
      6 => 'Silver',
      7 => 'Gold'
    }
    @cardFactory = CardFactory.new
  end

  def class_from_symbol(sym)
    Kernel.const_get(sym.to_s.split('_').collect(&:capitalize).join)
  end

  def new_deck
    deck = []
    7.times { deck << Copper.new }
    3.times { deck << Estate.new }
    deck.shuffle!
  end

  def draw(n)
    drawnCards = []
    while drawnCards.size < n && (!@contents.empty? || !@discard.empty?)
      if !@contents.empty?
        drawnCards << @contents.pop
      else
        fail "Ghost in the Discard!!!" if @discard.count(nil) > 0
        pp "Player has shuffled discard into their deck"
        @discard.shuffle!
        (@contents << @discard.pop(@discard.size)).flatten!
      end
    end
    drawnCards
  end

  def topdeck(card)
    @contents.unshift(card)
  end

  def buy(card)
    @discard << @cardFactory.buy(card) if @cardFactory.can_buy?(card)
  end

  def add_to_discard(cards)
    binding.pry if cards.nil?
    (@discard << cards).flatten!
  end

  def reveal
    p "You're not supposed to be here..."
    @contents.each do |c|
      print "#{@dictionary[c]}, "
    end
    p
  end

  def to_s
    "Contents of deck: #{hashify(@contents)} \n Contents of discard: #{hashify(@discard)}"
  end

  def get_all_of_card(target)
    matches = []
    @contents.each_with_index do |c, i|
      matches << { card: c, index: i } if c.is_a?(class_from_symbol(target))
    end
    @discard.each_with_index do |c, i|
      matches << { card: c, index: i } if c.is_a?(class_from_symbol(target))
    end
    matches
  end

  def hashify(set)
    uniques = set.uniq.sort
    hashed = {}
    uniques.each do |v|
      hashed[@dictionary[v]] = set.count(v)
    end
    hashed.to_s
  end

  def count(n)
    @contents.count(n) + @discard.count(n)
  end
end
