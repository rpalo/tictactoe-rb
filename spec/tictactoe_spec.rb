require "tictactoe"

describe TicTacToe do

  before :each do
    @game = TicTacToe.new
  end

  describe ".mark" do
    context "Given an x in the bottom left" do
      it "Should have an x in the bottom left" do
        @game.mark(:x, BOTTOM_LEFT)
        expect(@game.row(3)).to include(:x)
        expect(@game.col(1)).to include(:x)
      end
    end
    
    context "Given an o in the top right" do
      it "Should have an o in the top right" do
        @game.mark(:o, TOP_RIGHT)
        expect(@game.row(1)).to include(:o)
        expect(@game.col(3)).to include(:o)
      end
    end

    context "Given a z in the middle" do
      it "Should complain" do
        expect { @game.mark(:z, MIDDLE_MIDDLE) }.to raise_error(ArgumentError)
      end
    end

    context "Given an x at the 0th row" do
      it "Should complain" do
        bad_mark = Spot.new(row: 0, col: 2)
        expect { @game.mark(:x, bad_mark) }.to raise_error(ArgumentError)
      end
    end

    context "Given an x at the 4th column" do
      it "Should complain" do
      end
    end
  end

  describe ".winner" do
    context "given three x's in a row" do
      it "returns true" do
        skip
        game = TicTacToe.new
        game.mark({value: :x, row: 1, col: 1})
        game.mark({value: :x, row: 1, col: 2})
        game.mark({value: :x, row: 1, col: 3})
        expect(game.winner).to equal(true)
      end
    end
  end
end