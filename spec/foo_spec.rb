require_relative "../player"

RSpec.describe Player do

  describe "chen's algorithm" do
    subject { Chen.new }

    describe "#rank_value" do
      def invoke!(x)
        subject.rank_value(x)
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
  end

  describe "#score_hand_v1" do
    it "returns 13 when given a hand containing a K and a 5" do
      player = {
      }
player = JSON.parse(<<~EOF)
{
    "id": 1,                                // Your own player looks similar, with one extension.
    "name": "Bob",
    "status": "active",
    "version": "Default random player",
    "stack": 1590,
    "bet": 80,
    "hole_cards": [                         // The cards of the player. This is only visible for your own player
                                            //     except after showdown, when cards revealed are also included.
        {
            "rank": "6",                    // Rank of the card. Possible values are numbers 2-10 and J,Q,K,A
            "suit": "hearts"                // Suit of the card. Possible values are: clubs,spades,hearts,diamonds
        },
        {
            "rank": "K",
            "suit": "spades"
        }
    ]
}
EOF
      expect( subject.score_hand_v1(player) ).to eq( 13 )
    end
  end

end

RSpec.describe Chen do

  describe "gap" do
    it "answers 0 if the ranks are the same" do
      expect( subject.gap( "K", "K" ) ).to eq( 0 )
    end

    it "answers 1 if the ranks are one apart" do
      expect( subject.gap( "Q", "K" ) ).to eq( 1 )
      expect( subject.gap( "K", "Q" ) ).to eq( 1 )
    end

    it "answers the delta if the ranks are more than one apart" do
      expect( subject.gap( "7", "Q" ) ).to eq( 5 )
      expect( subject.gap( "Q", "7" ) ).to eq( 5 )
    end

  end

end
