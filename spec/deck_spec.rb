require_relative '../deck'

describe Deck do

  context "New deck with default order" do

    let (:deck) { Deck.new }

    it "should be 52 + 2 jokers" do
      expect(deck.cards.length).to eq(54)
    end

    it "contain two jokers" do
      expect(deck.cards.include?("A")).to eq true
      expect(deck.cards.include?("B")).to eq true
    end

    it "Move Jokers" do
      new_deck = deck.move_jokers
      expect(new_deck.index("A")).to eq 53
      expect(new_deck.index("B")).to eq 1
    end

    it "triple cut" do
      result = [
        ["B"],
        (2..52).to_a,
        ["A", 1]
      ].flatten

      deck.move_jokers
      expect(deck.triple_cut).to eq result
    end

    it "count cut" do
      deck.move_jokers
      deck.triple_cut
      result = [
        (2..52).to_a,
        ["A", "B", 1]
      ].flatten
      expect(deck.count_cut).to eq result
    end

    it "count cut" do
      deck.move_jokers
      deck.triple_cut
      deck.count_cut
      expect(deck.get_output_letter).to eq "D"
    end
       

    describe "keystream" do

      it "Total cards should equal 52 + 2 jokers" do
        expect(Deck.new.keystream(21)).to eq "DWJXH YRFDG TMSHP UURXJ"
      end

    end

  end

end