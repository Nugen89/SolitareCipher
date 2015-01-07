require_relative '../deck'

describe Deck do

  context "New deck" do

    describe "Total number of cards" do

      let (:deck) { Deck.new }

      it "should be 52 + 2 jokers" do
        expect(deck.cards.length).to eq(54)
      end

      it "contain two jokers" do
        expect(deck.cards.include?("A")).to eq true
        expect(deck.cards.include?("B")).to eq true
      end

      it "Move Jokers" do
        expect(deck.move_jokers).to eq true
      end

    end

    describe "keystream" do

      it "Total cards should equal 52 + 2 jokers" do
        Deck.new.keystream
      end

    end

  end

end