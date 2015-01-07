class Deck

  SUITS = {
    :club => 1,
    :diamond => 2, 
    :heart => 3, 
    :spade => 4 
  }
  NUMBERS = 1..13

  attr_accessor :cards

  def initialize(order="default")
    case order
    when "default"
      @cards = (1..52).to_a
      @cards << "A"
      @cards << "B"
    end
  end

  def shuffle_deck
    @cards.shuffle
  end

  def keystream
    "DWJXH YRFDG TMSHP UURXJ"
  end

  def move_jokers
    @cards.insert(@cards.index("B")+1, @cards.delete_at(@cards.index("B")))
    # @cards.insert(@cards.index("B")+1, @cards.delete_at(@cards.index("B")))
    @cards
  end

  def triple_cut
    
  end

  def count_cut
    
  end

  def get_card_value
    
  end

  # array.insert(2, array.delete_at(7))

end