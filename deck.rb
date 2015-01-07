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

  def keystream(length)
    result = []
    length.times do
      move_jokers
      triple_cut
      count_cut
      letter = get_output_letter
      result << letter unless letter.nil?
    end
    result.join.gsub(/(.{5})(?=.)/, '\1 \2')
  end

  def move_jokers
    if @cards.index("A") == @cards.length-1
      @cards.insert(1, @cards.delete_at(@cards.index("A")))
    else
      @cards.insert(@cards.index("A")+1, @cards.delete_at(@cards.index("A")))
    end

    if (@cards.length - @cards.index("B") == 1)
      @cards.insert(2, @cards.delete_at(@cards.index("B")))
    elsif (@cards.length - @cards.index("B") == 2)
      @cards.insert(1, @cards.delete_at(@cards.index("B")))
    else
      @cards.insert(@cards.index("B")+2, @cards.delete_at(@cards.index("B")))
    end
    @cards
  end

  def triple_cut
    a = @cards.index("A")
    b = @cards.index("B")
    a, b = b, a if a > b
    @cards = [ @cards[(b + 1)..-1],
                     @cards[a..b],
                     @cards[0...a] ].flatten
  end

  def count_cut
    last_card_value = @cards[-1]
    @cards = [
      @cards[last_card_value..-2],
      @cards[0..last_card_value-1],
      @cards[-1..-1]
    ].flatten
  end

  def get_output_letter
    a = @cards.first
    a = 53 if a.instance_of? String
    output = @cards[a]
    if output.instance_of? String
      nil
    else
      output -= 26 if output > 26
      (output + 64).chr
    end
  end

end