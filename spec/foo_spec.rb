require_relative "../player"

RSpec.describe "stuff" do

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

end
