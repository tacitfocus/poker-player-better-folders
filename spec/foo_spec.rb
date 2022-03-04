require_relative "../player"

RSpec.describe Player do

  describe "chen's algorithm" do
    subject { Chen }

    describe "#chen_value" do
      def invoke!(x)
        subject.chen_value(x)
      end

      it "answers 1 for a deuce" do
        expect( invoke!("2") ).to eq( 1 )
      end

      it "answers 1 for a trey" do
        expect( invoke!("3") ).to eq( 1 )
      end

      it "answers 5 for a T" do ; expect( invoke!("T") ).to eq( 5 ) ; end
      it "answers 6 for a J" do ; expect( invoke!("J") ).to eq( 6 ) ; end
      it "answers 7 for a Q" do ; expect( invoke!("Q") ).to eq( 7 ) ; end
      it "answers 8 for a K" do ; expect( invoke!("K") ).to eq( 8 ) ; end
      it "answers 10 for a A" do ; expect( invoke!("A") ).to eq( 10 ) ; end
    end
  end

  describe "computer_hand" do
    STACK_SIZE = 100
    before do
      allow(subject).to receive(:stack).and_return( STACK_SIZE )
      allow(subject).to receive(:player_data).and_return( player_data )
    end

    context "when gap is zero" do
      let(:player_data) {
        {
          "id"         => 1,
          "name"       => "Bob",
          "status"     => "active",
          "version"    => "Default random player",
          "stack"      => 1590,
          "bet"        => 80,
          "hole_cards" => [
            { "rank" => "6", "suit" => "hearts" },
            { "rank" => "6", "suit" => "spades" }
          ]
        }
      }

      it "goes all in" do
        expect( subject.computer_hand ).to eq( 100 )
      end
    end

    context "when gap is five^WFOUR (or less) and high card is Q" do
      let(:player_data) {
        {
          "id"         => 1,
          "name"       => "Bob",
          "status"     => "active",
          "version"    => "Default random player",
          "stack"      => 1590,
          "bet"        => 80,
          "hole_cards" => [
            { "rank" => "Q", "suit" => "hearts" },
            { "rank" => "8", "suit" => "spades" }
          ]
        }
      }

      it "goes all in" do
        expect( subject.computer_hand ).to eq( 100 )
      end
    end

    context "when gap is six (or more) and high card is < Q" do
      let(:player_data) {
        {
          "id"         => 1,
          "name"       => "Bob",
          "status"     => "active",
          "version"    => "Default random player",
          "stack"      => 1590,
          "bet"        => 80,
          "hole_cards" => [
            { "rank" => "Q", "suit" => "hearts" },
            { "rank" => "6", "suit" => "spades" }
          ]
        }
      }

      it "folds" do
        expect( subject.computer_hand ).to eq( 0 )
      end
    end

    context "When detecting a potential flush" do
      let(:player_data) {
        {
          "id"         => 1,
          "name"       => "Bob",
          "status"     => "active",
          "version"    => "Default random player",
          "stack"      => 1590,
          "bet"        => 80,
          "hole_cards" => [
            { "rank" => "Q", "suit" => "spades" },
            { "rank" => "6", "suit" => "spades" }
          ]
        }
      }

      it "goes all in" do
        expect( subject.computer_hand ).to eq( 100 )
      end
    end
  end

end


RSpec.describe Card do
  describe ".rank_value" do
    def invoke!(x)
      described_class.rank_value(x)
    end

    it "answers 2 for a deuce" do
      expect( invoke!("2") ).to eq( 2 )
    end

    it "answers 10 for a T" do ; expect( invoke!("T") ).to eq( 10 ) ; end
    it "answers 11 for a J" do ; expect( invoke!("J") ).to eq( 11 ) ; end
    it "answers 12 for a Q" do ; expect( invoke!("Q") ).to eq( 12 ) ; end
    it "answers 13 for a K" do ; expect( invoke!("K") ).to eq( 13 ) ; end
    it "answers 14 for a A" do ; expect( invoke!("A") ).to eq( 14 ) ; end
  end

  it "has a rank and suit from its JSON data" do
    card = Card.new( { "rank" => "Q", "suit" => "spades" } )
    expect( card.suit ).to eq( "spades" )
    expect( card.rank ).to eq( 12 )
  end
end


RSpec.describe Hand do
  def card(rank, suit)
    Card.new( { "rank" => rank, "suit" => suit } )
  end
  let(:ace_spades) {  }

  describe "#pair?" do
    it "answers true when the cards have the same rank" do
      c1 = card( "A", "spades" )
      c2 = card( "A", "clubs" )
      hand = Hand.new( c1, c2 )
      expect( hand ).to be_pair
    end

    it "answers false when the cards have different rank" do
      c1 = card( "A", "spades" )
      c2 = card( "K", "clubs" )
      hand = Hand.new( c1, c2 )
      expect( hand ).to_not be_pair
    end
  end

  describe "gap" do
    it "answers 0 if the ranks are the same" do
      c1 = card( "A", "spades" )
      c2 = card( "A", "clubs" )
      hand = Hand.new( c1, c2 )
      expect( hand.gap ).to eq( 0 )
    end

    it "answers 1 if the ranks are one apart" do
      c1 = card( "A", "spades" )
      c2 = card( "K", "clubs" )
      hand = Hand.new( c1, c2 )
      expect( hand.gap ).to eq( 1 )
    end

    it "answers the delta if the ranks are more than one apart" do
      c1 = card( "A", "spades" )
      c2 = card( "Q", "clubs" )
      hand = Hand.new( c1, c2 )
      expect( hand.gap ).to eq( 2 )
    end
  end
end
