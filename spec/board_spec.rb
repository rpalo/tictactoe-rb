require 'tictactoe'

describe TicTacToe::Board do

  before :each do
    @board = TicTacToe::Board.new
  end

  describe ".mark" do
    context "Given an x in the bottom left" do
      it "Should have an x in the bottom left" do
        @board.mark(:x, BOTTOM_LEFT)
        expect(@board.row(3)).to include(:x)
        expect(@board.col(1)).to include(:x)
      end
    end
    
    context "Given an o in the top right" do
      it "Should have an o in the top right" do
        @board.mark(:o, TOP_RIGHT)
        expect(@board.row(1)).to include(:o)
        expect(@board.col(3)).to include(:o)
      end
    end

    context "Given a z in the middle" do
      it "Should complain" do
        expect { @board.mark(:z, MIDDLE_MIDDLE) }.to raise_error(ArgumentError)
      end
    end

    context "Given an x at the 0th row" do
      it "Should complain" do
        bad_mark = Spot.new(row: 0, col: 2)
        expect { @board.mark(:x, bad_mark) }.to raise_error(ArgumentError)
      end
    end

    context "Given an x at the 4th column" do
      it "Should complain" do
        bad_mark = Spot.new(row: 1, col: 4)
        expect { @board.mark(:x, bad_mark) }.to raise_error(ArgumentError)
      end
    end

    context "When trying to mark an already taken spot" do
      it "Should complain" do
        @board.mark(:x, TOP_LEFT)
        expect { @board.mark(:o, TOP_LEFT) }.to raise_error(ArgumentError)
      end
    end

    context "When trying to mark on a board that's already full" do
      it "Should complain about full board" do
        @board.mark(:x, TOP_LEFT)
        @board.mark(:x, TOP_MIDDLE)
        @board.mark(:x, TOP_RIGHT)
        @board.mark(:x, MIDDLE_LEFT)
        @board.mark(:x, MIDDLE_MIDDLE)
        @board.mark(:x, MIDDLE_RIGHT)
        @board.mark(:x, BOTTOM_LEFT)
        @board.mark(:x, BOTTOM_MIDDLE)
        @board.mark(:x, BOTTOM_RIGHT)
        expect { @board.mark(:x, MIDDLE_MIDDLE) }.to raise_error(TicTacToe::FullBoardError)
      end
    end
  end
end