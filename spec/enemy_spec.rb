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

  describe TicTacToe::BasicEnemy do

    before :each do
      @enemy = TicTacToe::BasicEnemy.new
    end

    context "Given a blank board" do
      it "should provide a valid move" do
        expect(@enemy.move @board).to eq(TOP_LEFT)
      end
    end

    context "Given the first four spots taken" do
      it "should provide the middle spot" do
        @board.mark(:x, TOP_LEFT)
        @board.mark(:x, TOP_MIDDLE)
        @board.mark(:x, TOP_RIGHT)
        @board.mark(:x, MIDDLE_LEFT)
        expect(@enemy.move @board).to eq(MIDDLE_MIDDLE)
      end
    end
  end

  describe TicTacToe::RandomEnemy do

    before :each do
      @enemy = TicTacToe::RandomEnemy.new
    end

    context "Given a blank board" do
      it "Should not provide the same thing every time" do
        # Hard to test beyond that for randomness
        results = []
        10.times do
          results << @enemy.move(@board)
        end
        all_the_same = results.all? { |item| item == results.first }
        expect(all_the_same).not_to eq(true)
      end
    end
  end

  describe TicTacToe::DefensiveEnemy do

    before :each do
      @enemy = TicTacToe::DefensiveEnemy.new
    end

    context "If no danger" do
      it "should just take the next available spot" do
        @board.mark(:x, TOP_LEFT)
        expect(@enemy.move @board).to eq(TOP_MIDDLE)
      end
    end

    context "If x is about to win" do
      it "should try to stop that from happening" do
        @board.mark(:x, TOP_LEFT)
        @board.mark(:x, BOTTOM_LEFT)
        expect(@enemy.move @board).to eq(MIDDLE_LEFT)
      end
    end
  end

end