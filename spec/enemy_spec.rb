require 'tictactoe'

describe TicTacToe::Enemy do

  before :each do
    @board = TicTacToe::Board.new
  end

  describe "base enemy class" do
    context "When asked to move" do
      it "should raise NotImplementedError" do
        enemy = TicTacToe::Enemy.new
        expect { enemy.move @board }.to raise_error(NotImplementedError)
      end
    end
  end

  describe "move" do
    context "Given a blank board" do
      it "should provide a valid move" do
        skip
      end
    end
  end
end