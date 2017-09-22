
require_relative 'tictactoe/spot'

# Basic Game Controller for Tic Tac Toe
class TicTacToe
  def initialize
    @board = [
      [nil, nil, nil],
      [nil, nil, nil],
      [nil, nil, nil],
    ]
  end

  def mark(value, spot)
    @board[spot.row - 1][spot.col - 1] = value
  end

  def row(n)
    @board[n - 1]
  end

  def col(n)
    @board.map { |row| row[n - 1] }
  end
end

