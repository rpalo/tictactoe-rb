require 'tictactoe'

describe TicTacToe::Game do
  
  before :each do
    @game = TicTacToe::Game.new
    allow(@game).to receive(:puts)
  end

  describe ".winner" do
    context "given three x's in a row" do
      it "returns x wins" do
        @game.mark(:x, TOP_LEFT)
        @game.mark(:x, TOP_MIDDLE)
        @game.mark(:x, TOP_RIGHT)
        win = @game.winner
        expect(win[0]).to equal(true)
        expect(win[1]).to equal(:x)
      end
    end
    
    context "given three o's in a column" do
      it "returns o wins" do
        @game.mark(:o, TOP_LEFT)
        @game.mark(:o, MIDDLE_LEFT)
        @game.mark(:o, BOTTOM_LEFT)
        win = @game.winner
        expect(win[0]).to equal(true)
        expect(win[1]).to equal(:o)
      end
    end
    
    context "given three x's in a diagonal" do
      it "returns x wins" do
        @game.mark(:x, TOP_LEFT)
        @game.mark(:x, MIDDLE_MIDDLE)
        @game.mark(:x, BOTTOM_RIGHT)
        win = @game.winner
        expect(win[0]).to equal(true)
        expect(win[1]).to equal(:x)
      end
    end
  end

  describe "player_input" do
    context "Player puts in a valid row, column string with comma space" do
      it "returns the appropriate spot" do
        allow(@game).to receive(:gets).and_return("2, 2\n")
        expect(@game.player_input).to eq(MIDDLE_MIDDLE)
      end
    end
    context "Player puts in a valid row, column string with just space" do
      it "returns the appropriate spot" do
        allow(@game).to receive(:gets).and_return("2 2\n")
        expect(@game.player_input).to eq(MIDDLE_MIDDLE)
      end
    end
    context "Player puts in a valid row, column string with just comma" do
      it "returns the appropriate spot" do
        allow(@game).to receive(:gets).and_return("2,2\n")
        expect(@game.player_input).to eq(MIDDLE_MIDDLE)
      end
    end
    context "Player puts in a valid row, column string with no separation" do
      it "returns the appropriate spot" do
        allow(@game).to receive(:gets).and_return("22\n")
        expect(@game.player_input).to eq(MIDDLE_MIDDLE)
      end
    end
    context "Player puts in a invalid row, column string with letter" do
      it "retries until it's right" do
        allow(@game).to receive(:gets).and_return("2, a\n", "2, 2\n")
        expect(@game.player_input).to eq(MIDDLE_MIDDLE)
      end
    end
  end

  describe "play with two players" do
    context "Player plays against another player and x gets three" do
      it "should report that x wins" do
        moves = [
          "1, 1", # x
          "1, 2", # o
          "2, 1", # x
          "1, 3", # o
          "3, 1", # x  => x has 3 in a row
        ]
        allow(@game).to receive(:gets).and_return(*moves)
        expect(@game.play).to eq(:x)
      end
    end

    context "Player plays against another player and cat's game" do
      it "should return nil as winner" do
        moves = [
          "11",  # x
          "12",  # o
          "13",  # x
          "22",  # o
          "21",  # x
          "23",  # o
          "33",  # x
          "31",  # o
          "32",  # x
        ]
        allow(@game).to receive(:gets).and_return(*moves)
        expect(@game.play).to eq(nil)
      end
    end

    context "player plays an incorrect move" do
      it "should allow for retry and continue" do
        moves = [
          "11", # x
          "11", # o
          "12", # o retry after bad move
          "21", # x
          "22", # o
          "31", # x
        ]
        allow(@game).to receive(:gets).and_return(*moves)
        expect(@game.play).to eq(:x)
      end
    end
  end

  describe "play against a computer" do

    before :each do
      @game = TicTacToe::Game.new(TicTacToe::BasicEnemy.new)
      allow(@game).to receive(:puts)
    end

    context "player plays against a basic enemy and gets three" do
      it "should say that x wins" do
        moves = [
          "11", # x.  Expect o to take 12
          "21", # x.  Expect o to take 13
          "31"
        ]
        allow(@game).to receive(:gets).and_return(*moves)
        expect(@game.play).to eq(:x)
      end
    end

    context "player plays against a basic enemy and enemy gets 3" do
      it "should say that o wins" do
        moves = [
          "21", # x.  Expect o to take 11
          "22", # x.  Expect o to take 12
          "31", # x.  Expect o to take 13 and win
        ]
        allow(@game).to receive(:gets).and_return(*moves)
        expect(@game.play).to eq(:o)
      end
    end

    context "player plays against a basic enemy and ties" do
      it "should return nil" do
        moves = [
          "13", # x.  Expect o to take 11
          "21", # x.  Expect o to take 12
          "22", # x.  Expect o to take 23
          "32", # x.  Expect o to take 31
          "33", # x.  This should end the game.
        ]
        allow(@game).to receive(:gets).and_return(*moves)
        expect(@game.play).to eq(nil)
      end
    end
  end

end